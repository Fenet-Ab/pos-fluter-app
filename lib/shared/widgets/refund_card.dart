import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

/// A reusable refund card component with selection state.
class RefundCard extends StatelessWidget {
  final String orderId;
  final double amount;
  final String paymentMethod;
  final String time;
  final bool isSelected;
  final VoidCallback? onTap;

  const RefundCard({
    super.key,
    required this.orderId,
    required this.amount,
    required this.paymentMethod,
    required this.time,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4FF), // Light blue background
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? const Color(0xFFFF9500) : const Color(0xFFF1F4FF),
          width: 2.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFFFF9500).withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // Top Row: Order ID and Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orderId,
                      style: AppTextStyles.body(color: const Color(0xFF041B3C))
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: -0.5,
                          ),
                    ),
                    Text(
                      "ETB ${amount.toStringAsFixed(2)}",
                      style: AppTextStyles.body(color: const Color(0xFF041B3C))
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: -0.5,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Bottom Row: Payment Method and Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 22,
                          color: Color(0xFF535D7A),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Paid: $paymentMethod",
                          style: AppTextStyles.body(
                            color: const Color(0xFF535D7A),
                          ).copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Text(
                      time,
                      style: AppTextStyles.body(
                        color: const Color(0xFF535D7A),
                      ).copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
