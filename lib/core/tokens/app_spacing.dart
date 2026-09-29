import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Screen padding
  static const double screenPaddingMobile = 16.0;
  static const double screenPaddingWeb = 24.0;
  static const double maxContentWidth = 1200.0;

  // Border radii
  static const double radiusButton = 12.0;
  static const double radiusInput = 12.0;
  static const double radiusCard = 16.0;
  static const double radiusBottomSheet = 24.0;
  static const double radiusChip = 999.0;

  static const BorderRadius cardBorderRadius =
      BorderRadius.all(Radius.circular(radiusCard));
  static const BorderRadius buttonBorderRadius =
      BorderRadius.all(Radius.circular(radiusButton));
  static const BorderRadius inputBorderRadius =
      BorderRadius.all(Radius.circular(radiusInput));
  static const BorderRadius chipBorderRadius =
      BorderRadius.all(Radius.circular(radiusChip));
  static const BorderRadius bottomSheetBorderRadius =
      BorderRadius.vertical(top: Radius.circular(radiusBottomSheet));
}
