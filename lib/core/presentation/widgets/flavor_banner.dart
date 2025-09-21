import 'package:flutter/material.dart';

class FlavorBanner extends StatefulWidget {
  const FlavorBanner({super.key, required this.child, required this.isShow, required this.env});

  final bool isShow;

  final String? env;

  final Widget child;

  @override
  State<FlavorBanner> createState() => _FlavorBannerState();
}

class _FlavorBannerState extends State<FlavorBanner> {
  BannerPainter? _painter;

  @override
  void dispose() {
    _painter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isShow) return widget.child;

    final String env = widget.env?.toLowerCase() ?? '';

    if (env.isEmpty) return widget.child;

    _painter?.dispose();
    _painter = BannerPainter(
      message: env,
      textDirection: TextDirection.ltr,
      location: BannerLocation.topEnd,
      layoutDirection: TextDirection.ltr,
      color: Colors.red,
      textStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
    );

    return CustomPaint(foregroundPainter: _painter, child: widget.child);
  }
}
