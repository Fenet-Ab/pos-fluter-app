import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle heading({Color? color}) {
    return GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle subHeading({Color? color}) {
    return GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle body({Color? color}) {
    return GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.textSecondary,
    );
  }

  static TextStyle button({Color? color}) {
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.white,
    );
  }
}
