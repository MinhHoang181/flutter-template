import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.icon = const Icon(Icons.arrow_back_ios_new_rounded),
    this.color,
    this.canPop,
    this.onPressed,
  });

  final Widget icon;

  final Color? color;

  final VoidCallback? onPressed;

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
