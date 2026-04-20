import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

/// A reusable total display card matching the SAVVY POS design.
///
/// Used to display totals, prices, or any important key-value pair
/// with a prominent value display.
class TotalCard extends StatelessWidget {
  /// The label text (e.g., 'TOTAL').
  final String title;

  /// The prominent value text (e.g., 'ETB 440.00').
  final String value;

  /// Background color of the card. Defaults to light blue.
  final Color? backgroundColor;

  /// Color of the value text. Defaults to success green.
  final Color? valueColor;

  /// Height of the card.
  final double? height;

  /// The color of the card border.
  final Color? borderColor;

  /// The width of the card border.
  final double borderWidth;

  const TotalCard({
    super.key,
    this.title = 'TOTAL',
    required this.value,
    this.backgroundColor,
    this.valueColor,
    this.height,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFE9EEFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title.toUpperCase(),
            style:
                AppTextStyles.body(
                  color: const Color(
                    0xFF4A4E69,
                  ), // Matches the dark gray/blue in image
                ).copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.heading(
              color:
                  valueColor ??
                  const Color(0xFF32B37B), // Balanced success green
            ).copyWith(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
