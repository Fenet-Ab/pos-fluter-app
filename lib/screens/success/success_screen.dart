import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../../shared/widgets/custom_button.dart';
import '../../core/theme/app_colors.dart';
import 'package:intl/intl.dart';
import '../../core/utils/receipt_helper.dart';

class SuccessScreen extends StatefulWidget {
  final Uint8List? signatureImage;
  final String orderId;
  final DateTime? orderDate;
  final double totalAmount;
  final String paymentMethod;

  const SuccessScreen({
    super.key,
    this.signatureImage,
    this.orderId = "#SAV-94827-EP",
    DateTime? orderDate,
    this.totalAmount = 417.45,
    this.paymentMethod = "Bank Card",
  }) : orderDate = orderDate;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-navigate back to home after 5 seconds to simplify the POS experience
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Top Green Area
            Container(
              height: 320,
              width: double.infinity,
              color: const Color(0xFF3CB371), // A success green color
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'PAYMENT SUCCESSFUL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Transaction ID: ${widget.orderId}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Foreground Content (Overlapping Card)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 180,
                  left: 20,
                  right: 20,
                  bottom: 24,
                ),
                child: Column(
                  children: [
                    // Receipt Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'SAVVY IT - ADDIS ABABA',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4A4E69),
                              letterSpacing: 1.2,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'ETB ${widget.totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Color(
                                0xFF1E283C,
                              ), // Navy bold color for amount
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.payments_outlined,
                                size: 18,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Paid via: ${widget.paymentMethod}',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat(
                              'MMMM dd, yyyy • hh:mm a',
                            ).format(widget.orderDate ?? DateTime.now()),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Dashed Divider
                          const _DashedSeparator(
                            color: Color(0xFFE2E8F0),
                            height: 1.0,
                          ),

                          const SizedBox(height: 32),

                          // Subtotal
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                'ETB 363.00',
                                style: TextStyle(
                                  color: Color(0xFF1E283C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // VAT
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'VAT (15%)',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                'ETB 54.45',
                                style: TextStyle(
                                  color: Color(0xFF1E283C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          // Signature Box
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: widget.signatureImage != null
                                ? Image.memory(
                                    widget.signatureImage!,
                                    fit: BoxFit.contain,
                                  )
                                : Center(
                                    child: Text(
                                      'Signature',
                                      style: TextStyle(
                                        fontFamily: 'cursive',
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'CASHIER SIGNATURE',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 10,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Share Button
                    CustomButton(
                      text: 'Share Digital Link(QR)',
                      icon: Icons.qr_code,
                      iconLeading: true,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.primary,
                      textColor: AppColors.primary,
                      iconColor: AppColors.primary,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressed: () async {
                        await ReceiptHelper.shareReceipt(
                          orderId: widget.orderId,
                          orderDate: widget.orderDate ?? DateTime.now(),
                          totalAmount: widget.totalAmount,
                          signatureImage: widget.signatureImage,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF1A263E),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'NEW SALE',
              icon: Icons.add,
              iconLeading: true,
              mainAxisAlignment: MainAxisAlignment.center,
              onPressed: () {
                // Navigate to New Sale screen
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const _DashedSeparator({
    super.key,
    this.height = 1.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashSpace = 5.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
