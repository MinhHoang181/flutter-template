part of '../app_select_dropdown_menu.dart';

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
  ) =>
      _buildRoutePage(this, context, animation, secondaryAnimation);
}

Widget _buildRoutePage<T>(
  _PopupMenuRoute<T> route,
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
) {
  final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);

  final shape = route.menuModeProps.borderRadius != null
      ? null
      : route.menuModeProps.shape ?? popupMenuTheme.shape;

  final menu = Material(
    surfaceTintColor: route.menuModeProps.surfaceTintColor,
    shape: shape,
    color: route.menuModeProps.backgroundColor ?? popupMenuTheme.color,
    type: MaterialType.card,
    elevation: route.menuModeProps.elevation ?? popupMenuTheme.elevation ?? 8.0,
    clipBehavior: route.menuModeProps.clipBehavior,
    borderRadius: route.menuModeProps.borderRadius,
    animationDuration:
        route.menuModeProps.popUpAnimationStyle?.duration ??
        const Duration(milliseconds: 300),
    shadowColor: route.menuModeProps.shadowColor ?? popupMenuTheme.shadowColor,
    borderOnForeground: route.menuModeProps.borderOnForeground,
    child: route.child,
  );
  final MediaQueryData mediaQuery = MediaQuery.of(context);

  //handle menu margin
  var pos = route.position;
  if (route.menuModeProps.margin != null) {
    final margin = route.menuModeProps.margin!;
    pos = RelativeRect.fromLTRB(
      route.position.left + margin.left,
      route.position.top + margin.top,
      route.position.right + margin.right,
      route.position.bottom + margin.bottom,
    );
  }

  return CustomSingleChildLayout(
    delegate: _PopupMenuRouteLayout(
      padding: mediaQuery.padding,
      viewInsets: mediaQuery.viewInsets,
      position: pos,
    ),
    child: route.capturedThemes.wrap(menu),
  );
}
