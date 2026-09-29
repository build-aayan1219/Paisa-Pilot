import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Dark palette (Primary)
  static const Color darkBackground = Color(0xFF0B1020);
  static const Color darkSurface = Color(0xFF121A2F);
  static const Color darkSurfaceElevated = Color(0xFF182342);
  static const Color darkOutline = Color(0x14FFFFFF); // rgba(255,255,255,0.08)
  static const Color darkOutlineStrong = Color(0x28FFFFFF); // rgba(255,255,255,0.16)

  static const Color darkTextPrimary = Color(0xFFF5F7FF);
  static const Color darkTextSecondary = Color(0xFFA3ACC7);
  static const Color darkTextMuted = Color(0xFF6B7593);

  // Light palette (Mirrored)
  static const Color lightBackground = Color(0xFFF4F6FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFE9EEFA);
  static const Color lightOutline = Color(0x140B1020);
  static const Color lightOutlineStrong = Color(0x280B1020);

  static const Color lightTextPrimary = Color(0xFF0B1020);
  static const Color lightTextSecondary = Color(0xFF4A5578);
  static const Color lightTextMuted = Color(0xFF7E8BA6);

  // Semantic Status Colors
  static const Color emerald = Color(0xFF22C55E); // Safe / positive
  static const Color indigo = Color(0xFF6366F1); // Accent
  static const Color amber = Color(0xFFF59E0B); // Warning / alert
  static const Color rose = Color(0xFFF43F5E); // Danger / shortfall
  static const Color sky = Color(0xFF38BDF8); // Info / cold-start

  // Chart Palette
  static const Color chartIndigo = Color(0xFF6366F1);
  static const Color chartEmerald = Color(0xFF22C55E);
  static const Color chartAmber = Color(0xFFF59E0B);
  static const Color chartSky = Color(0xFF38BDF8);
  static const Color chartViolet = Color(0xFFA78BFA);
  static const Color chartPink = Color(0xFFF472B6);
  static const Color chartSlate = Color(0xFF94A3B8);

  static const List<Color> chartColors = [
    chartIndigo,
    chartEmerald,
    chartAmber,
    chartSky,
    chartViolet,
    chartPink,
    chartSlate,
  ];

  // Hero Card Glow BoxShadow
  static BoxShadow accentGlow({Color color = indigo}) => BoxShadow(
        color: color.withValues(alpha: 0.12),
        blurRadius: 24,
        spreadRadius: 0,
        offset: const Offset(0, 8),
      );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      darkSurfaceElevated,
      darkSurface,
    ],
  );

  static const LinearGradient lightHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      lightSurface,
      lightSurfaceElevated,
    ],
  );
}
