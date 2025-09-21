import 'dart:math';

import 'package:flutter/material.dart';
import 'package:template/core/presentation/widgets/skeleton/src/shimmer.dart';

part 'src/skeleton_container.dart';
part 'src/skeleton_line.dart';
part 'src/skeleton_paragraph.dart';

abstract class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.hasEffect = true});

  /// Flag to determine if the skeleton has an effect
  final bool hasEffect;

  /// Function to generate a random double within a range
  double randomInRange(num start, num end) => Random().nextDouble() * (end - start) + start;

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surfaceBright;

    // Building the skeleton
    Widget child = skeletonBuilder(context, baseColor, highlightColor);

    // If the skeleton has an effect, apply the ShimmerEffect
    if (hasEffect) {
      child = Shimmer.fromColors(baseColor: baseColor, highlightColor: highlightColor, child: child);
    }

    return child;
  }

  /// create a skeleton widget
  Widget skeletonBuilder(BuildContext context, Color baseColor, Color highlightColor);
}
