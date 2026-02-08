import 'package:flutter/material.dart';

/// A custom back button that automatically handles [Navigator.maybePop].
///
/// It only displays if the current route can be popped.
class AppBackButton extends StatelessWidget {
  /// Creates an [AppBackButton].
  const AppBackButton({
    super.key,
    this.icon = const Icon(Icons.arrow_back_ios_new_rounded),
    this.color,
    this.canPop,
    this.onPressed,
  });

  /// The icon to display.
  final Widget icon;

  /// The color of the icon.
  final Color? color;

  /// Callback when the button is pressed.
  ///
  /// If null, it will unfocus the current focus and call [Navigator.maybePop].
  final VoidCallback? onPressed;

  /// Whether the button should be displayed.
  ///
  /// If null, it will use [ModalRoute.canPop].
  final bool? canPop;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final bool check = canPop ?? parentRoute?.canPop ?? false;

    if (!check) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: icon,
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            FocusManager.instance.primaryFocus?.unfocus();
          });
          Navigator.maybePop(context);
        }
      },
    );
  }
}
