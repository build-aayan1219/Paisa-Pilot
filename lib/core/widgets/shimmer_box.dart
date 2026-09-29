import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';

class ShimmerBox extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  const ShimmerBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  const ShimmerBox.circular({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        borderRadius = null,
        shape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated;
    final highlightColor =
        isDark ? const Color(0xFF223055) : const Color(0xFFDCE4F5);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: baseColor,
        shape: shape,
        borderRadius: shape == BoxShape.circle
            ? null
            : (borderRadius ?? BorderRadius.circular(AppSpacing.xs)),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .tint(color: highlightColor, duration: 900.ms, curve: Curves.easeInOut);
  }
}
