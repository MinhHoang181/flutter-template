part of '../app_select_dropdown_menu.dart';

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout({
    required this.padding,
    required this.viewInsets,
    required this.position,
  });

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The padding of unsafe area.
  final EdgeInsets padding;

  // The view insets (typically for the keyboard).
  final EdgeInsets viewInsets;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      _getRouteConstraints(this, constraints);

  @override
  Offset getPositionForChild(Size size, Size childSize) =>
      _getRoutePosition(this, size, childSize);

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position ||
        padding != oldDelegate.padding ||
        viewInsets != oldDelegate.viewInsets;
  }
}

BoxConstraints _getRouteConstraints(
  _PopupMenuRouteLayout layout,
  BoxConstraints constraints,
) {
  // keyBoardHeight is height of keyboard if showing
  final double keyBoardHeight = layout.viewInsets.bottom;
  final double safeAreaTop = layout.padding.top;
  final double safeAreaBottom = layout.padding.bottom;
  final double safeAreaTotal = safeAreaTop + safeAreaBottom;

  return BoxConstraints.loose(
    Size(
      constraints.minWidth - layout.position.left - layout.position.right,
      constraints.minHeight,
    ),
  ).deflate(
    EdgeInsets.only(top: safeAreaTotal + keyBoardHeight) + layout.padding,
  );
}

Offset _getRoutePosition(
  _PopupMenuRouteLayout layout,
  Size size,
  Size childSize,
) {
  // keyBoardHeight is height of keyboard if showing
  final double keyBoardHeight = layout.viewInsets.bottom;

  double x = layout.position.left;

  // Find the ideal vertical position.
  double y = layout.position.top;
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
