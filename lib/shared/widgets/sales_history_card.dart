import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

/// A reusable sales history card component matching the SAVVY POS design.
class SalesHistoryCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String time;
  final int itemCount;
  final double amount;
  final VoidCallback? onTap;

  const SalesHistoryCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.time,
    required this.itemCount,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine theme based on status
    final statusUpper = status.toUpperCase();
    IconData iconData;
    Color iconColor;
    Color iconBgColor;

    switch (statusUpper) {
      case 'REFUNDED':
        iconData = Icons.undo_rounded;
        iconColor = const Color(0xFFD48B00);
        iconBgColor = const Color(0xFFFFF3DB);
        break;
      case 'FAILED':
        iconData = Icons.error_outline_rounded;
        iconColor = const Color(0xFFDE350B);
        iconBgColor = const Color(0xFFFFE9E9);
        break;
      case 'COMPLETED':
      default:
        iconData = Icons.receipt_long_rounded;
        iconColor = const Color(0xFF003D95);
        iconBgColor = const Color(0xFFDDE4FF);
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4FF), // Light blue background for the card
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Status-specific Icon in a box
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),

              // Middle: Order Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            orderId,
                            style: AppTextStyles.body(
                              color: const Color(0xFF041B3C),
                            ).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _StatusBadge(status: status),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "$time • $itemCount Items",
                      style: AppTextStyles.body(
                        color: const Color(0xFF535D7A),
                      ).copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Right: Amount and Chevron
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "ETB",
                    style: AppTextStyles.body(
                      color: const Color(0xFF041B3C),
                    ).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    amount.toStringAsFixed(2),
                    style: AppTextStyles.body(
                      color: const Color(0xFF041B3C),
                    ).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFAAB2C8),
                    size: 24,
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

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status.toUpperCase()) {
      case 'COMPLETED':
        bgColor = const Color(0xFFD9F2E9);
        textColor = const Color(0xFF2EA572);
        break;
      case 'REFUNDED':
        bgColor = const Color(0xFFFFF3DB);
        textColor = const Color(0xFFD48B00);
        break;
      case 'FAILED':
        bgColor = const Color(0xFFFFE9E9);
        textColor = const Color(0xFFDE350B);
        break;
      case 'PENDING':
        bgColor = const Color(0xFFFFF3DB);
        textColor = const Color(0xFFD48B00);
        break;
      default:
        bgColor = const Color(0xFFE9EEFF);
        textColor = const Color(0xFF535D7A);
    }


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: textColor.withOpacity(0.2)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
