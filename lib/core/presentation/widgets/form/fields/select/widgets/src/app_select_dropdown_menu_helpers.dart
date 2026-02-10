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
