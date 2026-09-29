import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';

enum AppCardVariant { standard, elevated, hero }

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final AppCardVariant variant;
  final Color? glowColor;
  final Color? borderColor;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.variant = AppCardVariant.standard,
    this.glowColor,
    this.borderColor,
    this.width,
    this.height,
  });

  const AppCard.elevated({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.glowColor,
    this.borderColor,
    this.width,
    this.height,
  }) : variant = AppCardVariant.elevated;

  const AppCard.hero({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.glowColor = AppColors.indigo,
    this.borderColor,
    this.width,
    this.height,
  }) : variant = AppCardVariant.hero;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Decoration decoration;
    switch (variant) {
      case AppCardVariant.hero:
        decoration = BoxDecoration(
          gradient: isDark ? AppColors.heroGradient : AppColors.lightHeroGradient,
          borderRadius: AppSpacing.cardBorderRadius,
          border: Border.all(
            color: borderColor ??
                (isDark ? AppColors.darkOutlineStrong : AppColors.lightOutlineStrong),
            width: 1,
          ),
          boxShadow: [
            AppColors.accentGlow(color: glowColor ?? AppColors.indigo),
          ],
        );
        break;
      case AppCardVariant.elevated:
        decoration = BoxDecoration(
          color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
          borderRadius: AppSpacing.cardBorderRadius,
          border: Border.all(
            color: borderColor ??
                (isDark ? AppColors.darkOutline : AppColors.lightOutline),
            width: 1,
          ),
        );
        break;
      case AppCardVariant.standard:
        decoration = BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: AppSpacing.cardBorderRadius,
          border: Border.all(
            color: borderColor ??
                (isDark ? AppColors.darkOutline : AppColors.lightOutline),
            width: 1,
          ),
        );
        break;
    }

    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: AppSpacing.cardBorderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.cardBorderRadius,
          child: content,
        ),
      );
    }

    return content;
  }
}
