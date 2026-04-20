import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final Color? textColor;
  final Color? iconColor;
  final IconData? icon;
  final MainAxisAlignment mainAxisAlignment;

  final double spacing;
  final bool iconLeading;
  final double height;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.textColor,
    this.iconColor,
    this.icon,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.spacing = 8.0,
    this.iconLeading = false,
    this.height = 56.0,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (icon != null && iconLeading) ...[
              Icon(
                icon,
                size: 20,
                color: iconColor ?? textColor ?? Colors.white,
              ),
              SizedBox(width: spacing),
            ],
            Text(
              text,
              style: AppTextStyles.subHeading(color: textColor ?? Colors.white),
            ),
            if (icon != null && !iconLeading) ...[
              SizedBox(width: spacing),
              Icon(
                icon,
                size: 20,
                color: iconColor ?? textColor ?? Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
