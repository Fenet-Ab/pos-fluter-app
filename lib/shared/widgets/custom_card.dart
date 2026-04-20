import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A premium action card component designed for grid layouts or quick actions.
///
/// This card features a prominent icon in a stylized container followed by
/// a bold title, matching the design aesthetic of the SAVVY POS system.
class CustomCard extends StatelessWidget {
  /// The icon to display in the center of the card.
  final IconData icon;

  /// The label text displayed below the icon.
  final String title;

  /// Callback function when the card is tapped.
  final VoidCallback? onTap;

  /// The color of the icon (defaults to brand primary).
  final Color? iconColor;

  /// The background color of the icon container (defaults to light primary).
  final Color? iconBackgroundColor;

  /// The semantic color of the text (defaults to primary text color).
  final Color? textColor;

  /// Whether to add a subtle shadow to the card.
  final bool showShadow;

  /// The color of the card border.
  final Color? borderColor;

  /// The width of the card border.
  final double borderWidth;

  const CustomCard({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.iconBackgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor ?? AppColors.border,
          width: borderWidth,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          hoverColor: AppColors.primary.withOpacity(0.05),
          highlightColor: AppColors.primary.withOpacity(0.05),
          splashColor: AppColors.primary.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    iconBackgroundColor ?? AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: 26,
              ),
            ),

            const SizedBox(height: 4),

            // Bold Text Label
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body().copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                color: textColor ?? AppColors.textPrimary,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
          ),
        ),
      ),
    );
  }
}
