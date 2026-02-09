import 'package:flutter/material.dart';

import '../../../../../../theme/app_radius.dart';
import '../../../../../../theme/app_spacing.dart';
import '../../../../../../utils/either.dart';
import '../../../../app_icon.dart';
import '../../../../app_text.dart';
import '../base/app_select_typedefs.dart';
import '../data_source/app_select_data_source.dart';
import 'app_select_paginated_list_view.dart';

enum _UnselectedValue { value }

const _UnselectedValue _unselectedValue = _UnselectedValue.value;

/// Dropdown menu widget for selecting a single item
///
/// This widget displays a dropdown menu overlay that can show either a fixed
/// list of items or a paginated list loaded from a data source.
///
/// Features:
/// - Single selection only
/// - Fixed list or paginated data source support
/// - Material Design styling
/// - Automatic positioning relative to trigger widget
/// - Customizable menu alignment and constraints
///
/// Usage with fixed list:
/// ```dart
/// final result = await AppSelectDropdownMenu.showSingle<String>(
///   context,
///   items: ['Option 1', 'Option 2', 'Option 3'],
///   selectedItem: currentValue,
/// );
/// ```
///
/// Usage with data source:
/// ```dart
/// final result = await AppSelectDropdownMenu.showSingle<Customer>(
///   context,
///   dataSource: customerDataSource,
///   selectedItem: currentCustomer,
///   itemDisplay: (customer) => customer.name,
///   itemIdentity: (customer) => customer.id,
/// );
/// ```
///
/// Returns:
/// - `Right(value)` when a selection is made
/// - `Left(null)` when unselected (tapping already selected item)
/// - `null` when cancelled (tapping outside)
class AppSelectDropdownMenu<T> extends StatefulWidget {
  const AppSelectDropdownMenu._({
    required this.dataSource,
    required this.selectedItem,
    required this.itemDisplay,
    required this.itemIdentity,
  });

  /// Show dropdown menu for single selection
  ///
  /// Use [items] for fixed list or [dataSource] for paginated/custom data source.
  /// If both are provided, [dataSource] takes priority.
  static Future<Either<Null, T>?> showSingle<T>(
    BuildContext context, {
    DropdownMenuProps menuProps = const DropdownMenuProps(),
    BoxConstraints constraints = const BoxConstraints(),
    required AppSelectDataSource<T> dataSource,
    T? selectedItem,
    required AppItemDisplay<T> itemDisplay,
    required AppItemIdentity<T> itemIdentity,
  }) async {
    final dropdownObject = context.findRenderObject()! as RenderBox;
    final overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;

    final result = await _showMenu<T>(
      context: context,
      menuModeProps: menuProps,
      position: _position(dropdownObject, overlay, constraints, menuProps),
      child: AppSelectDropdownMenu<T>._(
        dataSource: dataSource,
        selectedItem: selectedItem,
        itemDisplay: itemDisplay,
        itemIdentity: itemIdentity,
      ),
    );

    return _parseResult(result);
  }

  static Either<Null, T>? _parseResult<T>(Object? result) {
    if (result == null) return null;

    if (result == _unselectedValue) {
      return const Left(null);
    }

    if (result is T) {
      return Right(result as T);
    }

    return null;
  }

  /// Data source for loading items
  final AppSelectDataSource<T> dataSource;

  /// Currently selected item
  final T? selectedItem;

  /// Item display function
  final AppItemDisplay<T> itemDisplay;

  /// Item identity function for comparison
  final AppItemIdentity<T> itemIdentity;

  @override
  State<AppSelectDropdownMenu<T>> createState() =>
      _AppSelectDropdownMenuState<T>();
}

class _AppSelectDropdownMenuState<T> extends State<AppSelectDropdownMenu<T>> {
  void _onTap(T item) {
    // Close immediately on tap
    if (_isSelected(item)) {
      Navigator.of(context).pop(_unselectedValue);
    } else {
      Navigator.of(context).pop(item);
    }
  }

  bool _isSelected(T item) {
    if (widget.selectedItem == null) return false;
    return widget.itemIdentity(widget.selectedItem as T) ==
        widget.itemIdentity(item);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300, minWidth: 112),
        child: AppSelectPaginatedListView<T>(
          shrinkWrap: true,
          dataSource: widget.dataSource,
          itemDisplay: widget.itemDisplay,
          getItemIdentity: widget.itemIdentity,
          itemBuilder: _buildMenuItem,
          separatorBuilder: _buildDivider,
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, T item) {
    final isSelected = _isSelected(item);

    return InkWell(
      onTap: () => _onTap(item),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: AppText(
                widget.itemDisplay(item),
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: null,
              ),
            ),
            if (isSelected) ...[
              Transform.translate(
                offset: const Offset(0, 2),
                child: AppIcon(
                  icon: Icons.check,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context, int index) {
    return const SizedBox.shrink();
  }
}

///the goal of this function is to return a position of the popup
///taking in consideration menu button width and popup constraints
RelativeRect _position(
  RenderBox dropdown,
  RenderBox overlay,
  BoxConstraints constraints,
  DropdownMenuProps menuProps,
) {
  final menuMinWidth = constraints.minWidth;
  final menuMaxWidth = constraints.maxWidth;

  final menuMinHeight = constraints.minHeight;
  final menuMaxHeight = constraints.maxHeight;

  var menuWidth = dropdown.size.width;
  var menuHeight = 350.0;

  if (menuMinWidth > 0) {
    menuWidth = menuMinWidth;
  }
  if (menuMaxWidth > 0 && menuMaxWidth < menuWidth) {
    menuWidth = menuMaxWidth;
  }
  if (dropdown.size.width < 64) {
    menuWidth = 180;
  }

  if (menuMinHeight > 0) {
    menuHeight = menuMinHeight;
  }
  if (menuMaxHeight > 0 && menuMaxHeight < menuHeight) {
    menuHeight = menuMaxHeight;
  }

  return _getPosition(
    dropdown,
    overlay,
    Size(menuWidth, menuHeight),
    menuProps.align,
  );
}

/// Calculate dropdown menu position relative to the trigger widget.
///
/// Returns [RelativeRect] for positioning the popup menu based on [menuAlign].
RelativeRect _getPosition(
  RenderBox dropdown,
  RenderBox overlay,
  Size menuSize,
  DropdownMenuAlign? menuAlign,
) {
  final dropdownOffset = dropdown.localToGlobal(Offset.zero, ancestor: overlay);
  final dropdownSize = dropdown.size;

  // Calculate horizontal positions
  final startX = dropdownOffset.dx;
  final centerX = dropdownOffset.dx + (dropdownSize.width - menuSize.width) / 2;
  final endX = dropdownOffset.dx + dropdownSize.width - menuSize.width;

  // Calculate vertical positions
  final bottomY = dropdownOffset.dy + dropdownSize.height;

  // Get position based on alignment
  final (dX, dY) = switch (menuAlign) {
    DropdownMenuAlign.bottomStart => (startX, bottomY),
    DropdownMenuAlign.bottomCenter => (centerX, bottomY),
    DropdownMenuAlign.bottomEnd => (endX, bottomY),
    null => (endX, bottomY), // default: bottomEnd
  };

  return RelativeRect.fromSize(Offset(dX, dY) & menuSize, overlay.size);
}

enum DropdownMenuAlign {
  bottomStart,
  bottomCenter,
  bottomEnd,
}

class DropdownMenuProps {
  const DropdownMenuProps({
    this.align,
    this.barrierLabel,
    this.elevation,
    this.shape,
    this.barrierColor,
    this.backgroundColor,
    this.barrierDismissible = true,
    this.clipBehavior = Clip.hardEdge,
    this.borderOnForeground = false,
    this.borderRadius = const BorderRadius.all(AppRadius.lg),
    this.shadowColor,
    this.color,
    this.popUpAnimationStyle,
    this.semanticLabel,
    this.surfaceTintColor,
    this.margin,
  });
  final DropdownMenuAlign? align;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final bool borderOnForeground;
  final String? barrierLabel;
  final AnimationStyle? popUpAnimationStyle;
  final Color? color;
  final String? semanticLabel;
  final Color? surfaceTintColor;
  final EdgeInsets? margin;
}

Future<T?> _showMenu<T>({
  required BuildContext context,
  required DropdownMenuProps menuModeProps,
  required RelativeRect position,
  required Widget child,
}) {
  final NavigatorState navigator = Navigator.of(context);
  return navigator.push(
    _PopupMenuRoute<T>(
      context: context,
      position: position,
      child: child,
      menuModeProps: menuModeProps,
      capturedThemes: InheritedTheme.capture(
        from: context,
        to: navigator.context,
      ),
    ),
  );
}

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(this.padding, this.viewInsets, this.position);
  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The padding of unsafe area.
  final EdgeInsets padding;

  // The view insets of the screen (keyboard height etc).
  final EdgeInsets viewInsets;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    //keyBoardHeight is height of keyboard if showing
    final double keyBoardHeight = viewInsets.bottom;
    final double safeAreaTop = padding.top;
    final double safeAreaBottom = padding.bottom;
    final double safeAreaTotal = safeAreaTop + safeAreaBottom;

    return BoxConstraints.loose(
      Size(
        constraints.minWidth - position.left - position.right,
        constraints.minHeight,
      ),
    ).deflate(EdgeInsets.only(top: safeAreaTotal + keyBoardHeight) + padding);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    //keyBoardHeight is height of keyboard if showing
    final double keyBoardHeight = viewInsets.bottom;

    double x = position.left;

    // Find the ideal vertical position.
    double y = position.top;
    // check if we are in the bottom
    if (y + childSize.height > size.height - keyBoardHeight) {
      y = size.height - childSize.height - keyBoardHeight;
    } else if (y < 0) {
      y = 8;
    }

    if (x + childSize.width > size.width) {
      x = size.width - childSize.width;
    } else if (x < 0) {
      x = 8;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    return oldDelegate.padding != padding ||
        oldDelegate.viewInsets != viewInsets ||
        oldDelegate.position != position;
  }
}

class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute({
    required this.context,
    required this.menuModeProps,
    required this.position,
    required this.capturedThemes,
    required this.child,
  });
  final DropdownMenuProps menuModeProps;
  final BuildContext context;
  final RelativeRect position;
  final Widget child;
  final CapturedThemes capturedThemes;

  @override
  Duration get transitionDuration =>
      menuModeProps.popUpAnimationStyle?.duration ??
      const Duration(milliseconds: 100);

  @override
  bool get barrierDismissible => menuModeProps.barrierDismissible;

  @override
  Color? get barrierColor => menuModeProps.barrierColor;

  @override
  String? get barrierLabel => menuModeProps.barrierLabel;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);

    final shape = menuModeProps.borderRadius != null
        ? null
        : menuModeProps.shape ?? popupMenuTheme.shape;

    final menu = Material(
      surfaceTintColor: menuModeProps.surfaceTintColor,
      shape: shape,
      color: menuModeProps.backgroundColor ?? popupMenuTheme.color,
      type: MaterialType.card,
      elevation: menuModeProps.elevation ?? popupMenuTheme.elevation ?? 8.0,
      clipBehavior: menuModeProps.clipBehavior,
      borderRadius: menuModeProps.borderRadius,
      animationDuration:
          menuModeProps.popUpAnimationStyle?.duration ??
          const Duration(milliseconds: 300),
      shadowColor: menuModeProps.shadowColor ?? popupMenuTheme.shadowColor,
      borderOnForeground: menuModeProps.borderOnForeground,
      child: child,
    );
    final padding = MediaQuery.paddingOf(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);

    //handle menu margin
    var pos = position;
    if (menuModeProps.margin != null) {
      final margin = menuModeProps.margin!;
      pos = RelativeRect.fromLTRB(
        position.left + margin.left,
        position.top + margin.top,
        position.right + margin.right,
        position.bottom + margin.bottom,
      );
    }

    return CustomSingleChildLayout(
      delegate: _PopupMenuRouteLayout(padding, viewInsets, pos),
      child: capturedThemes.wrap(menu),
    );
  }
}
