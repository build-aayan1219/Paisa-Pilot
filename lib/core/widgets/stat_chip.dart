import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';

enum StatChipStatus { onTrack, watchOut, shortfallRisk, info, neutral }

class StatChip extends StatelessWidget {
  final String label;
  final StatChipStatus? status;
  final Color? customColor;
  final IconData? icon;
  final VoidCallback? onTap;

  const StatChip({
    super.key,
    required this.label,
    this.status,
    this.customColor,
    this.icon,
    this.onTap,
  });

  Color _resolveColor() {
    if (customColor != null) return customColor!;
    switch (status ?? StatChipStatus.neutral) {
      case StatChipStatus.onTrack:
        return AppColors.emerald;
      case StatChipStatus.watchOut:
        return AppColors.amber;
      case StatChipStatus.shortfallRisk:
        return AppColors.rose;
      case StatChipStatus.info:
        return AppColors.sky;
      case StatChipStatus.neutral:
        return AppColors.indigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor();
    final theme = Theme.of(context);

    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: AppSpacing.chipBorderRadius,
        border: Border.all(
          color: color.withValues(alpha: 0.28),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 5),
          ] else ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.chipBorderRadius,
        child: chip,
      );
    }

    return chip;
  }
}
