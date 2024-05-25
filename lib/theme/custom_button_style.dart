import 'dart:ui';
import 'package:customers_payments/app_colors.dart';

import '../../core/app_export.dart';
import 'package:flutter/material.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillBlue => ElevatedButton.styleFrom(
        backgroundColor: appTheme.blue700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );

  // Outline button style
  static ButtonStyle get outlineBlackTL24 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.blue700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.h),
        ),
        shadowColor: appTheme.black900.withOpacity(0.25),
        elevation: 2,
      );

  //Red Button Done
  static ButtonStyle get redButton => ElevatedButton.styleFrom(
    backgroundColor: appTheme.redA700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.h),
    ),
    shadowColor: appTheme.black900.withOpacity(0.25),
    elevation: 2,
  );

  //Red Button Done
  static ButtonStyle get redButtonForHour => ElevatedButton.styleFrom(
    backgroundColor: appTheme.redA700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.h),
    ),
    shadowColor: appTheme.black900.withOpacity(0.25),
    alignment: Alignment.center,
    elevation: 2,
  );

  //Green Button Done
  static ButtonStyle get greenButton => ElevatedButton.styleFrom(
    backgroundColor: appTheme.lightGreenA700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.h),
    ),
    shadowColor: appTheme.black900.withOpacity(0.25),
    elevation: 2,
  );

  //yellow Button pause
  static ButtonStyle get yellowButton => ElevatedButton.styleFrom(
    backgroundColor: AppColors.warningColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.h),
    ),
    shadowColor: appTheme.black900.withOpacity(0.25),
    elevation: 2,
  );

  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
