part of '../app_select_dropdown_menu.dart';

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
  _PopupMenuRouteLayout({
    required this.position,
    required this.padding,
    required this.viewInsets,
  });

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The padding of unsafe area.
  final EdgeInsets padding;

  // The view insets of the screen (e.g. keyboard height).
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
    return oldDelegate.position != position ||
        oldDelegate.padding != padding ||
        oldDelegate.viewInsets != viewInsets;
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
      delegate: _PopupMenuRouteLayout(
        position: pos,
        padding: MediaQuery.paddingOf(context),
        viewInsets: MediaQuery.viewInsetsOf(context),
      ),
      child: capturedThemes.wrap(menu),
    );
  }
}
