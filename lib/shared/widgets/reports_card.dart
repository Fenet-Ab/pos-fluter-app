import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A reusable reports card component designed for the SAVVY POS system.
///
/// This card displays a label and a corresponding financial amount,
/// accompanied by a status icon, matching the design aesthetic of the reports section.
class ReportsCard extends StatelessWidget {
  /// The label/title of the report item (e.g., CASH IN TILL).
  final String title;

  /// The monetary amount to display.
  final double amount;

  /// The icon to represent this report item.
  /// If provided, this will be used regardless of [type].
  final IconData? icon;

  /// Predefined type to automatically select the icon.
  /// Supported values: 'CASH', 'TELEBIRR', 'CBEBIRR', 'CARD'.
  final String? type;

  /// The currency code (defaults to ETB).
  final String currency;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  const ReportsCard({
    super.key,
    required this.title,
    required this.amount,
    this.icon,
    this.type,
    this.currency = "ETB",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the icon based on type or provided icon
    IconData displayIcon = icon ?? Icons.help_outline_rounded;
    if (type != null) {
      switch (type!.toUpperCase()) {
        case 'CASH':
          displayIcon = Icons.payments_rounded;
          break;
        case 'TELEBIRR':
          displayIcon = Icons.smartphone_rounded;
          break;
        case 'CBEBIRR':
          displayIcon = Icons.account_balance_rounded;
          break;
        case 'CARD':
          displayIcon = Icons.credit_card_rounded;
          break;
      }
    }
    // Format the amount with commas and 2 decimal places
    final String formattedAmount = amount
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.3), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Icon Box
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDE4FF), // Light blue background
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  displayIcon,
                  color: const Color(0xFF003D95), // Deep blue icon
                  size: 32,
                ),
              ),

              const SizedBox(width: 20),

              // Title Section
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: AppTextStyles.body(
                    color: AppColors.textPrimary,
                  ).copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
              ),

              // Amount Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    currency,
                    style: AppTextStyles.body(
                      color: AppColors.textPrimary,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    formattedAmount,
                    style: AppTextStyles.body(
                      color: AppColors.textPrimary,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
