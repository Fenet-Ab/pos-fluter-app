import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A reusable settings card component matching the SAVVY POS design.
///
/// This card displays an icon, a title, a subtitle, and a chevron trailing icon,
/// ideal for settings menus or navigation lists.
class SettingCard extends StatelessWidget {
  /// The icon to display on the left.
  final IconData icon;

  /// The main label of the setting.
  final String title;

  /// The descriptive text below the title.
  final String subtitle;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// The background color of the icon container.
  final Color? iconBackgroundColor;

  /// The color of the icon.
  final Color? iconColor;

  /// Optional custom trailing widget (e.g. a Switch). If null, defaults to a chevron.
  final Widget? trailing;

  /// Optional overriding color of the title text.
  final Color? titleColor;

  const SettingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.iconBackgroundColor,
    this.iconColor,
    this.trailing,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.2), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBackgroundColor ?? const Color(0xFFF4F6F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? const Color(0xFF434654),
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.body(
                        color: titleColor ?? AppColors.textPrimary,
                      ).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.body(
                        color: const Color(0xFF8A94A6),
                      ).copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Trailing Widget or Chevron
              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFAAB2C8),
                    size: 24,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
