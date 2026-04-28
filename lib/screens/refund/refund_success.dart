import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/footer.dart';
import '../../core/utils/receipt_helper.dart';

import '../../models/order_model.dart';

class RefundSuccessScreen extends StatefulWidget {
  final Order? order;
  const RefundSuccessScreen({super.key, this.order});

  @override
  State<RefundSuccessScreen> createState() => _RefundSuccessScreenState();
}

class _RefundSuccessScreenState extends State<RefundSuccessScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FC),
      body: Stack(
        children: [
          // Green Background Top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              color: AppColors.success,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // Checkmark Icon Container
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2), // Semi-transparent overlay
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: AppColors.success,
                            size: 32,
                            weight: 800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "REFUND SUCCESSFUL",
                      style: AppTextStyles.heading(color: Colors.white).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "REFERENCE ID: ${widget.order?.id ?? '#SAV-94827-EP'}",
                      style: AppTextStyles.body(color: Colors.white.withOpacity(0.9)).copyWith(
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Foreground Scrollable Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 200), // Push the card down
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          // Receipt Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  "MERCHANT RECEIPT",
                                  style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Savvy IT - Addis Ababa",
                                  style: AppTextStyles.heading(color: AppColors.textPrimary).copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Divider(color: Color(0xFFF0F1F5), thickness: 1),
                                const SizedBox(height: 20),
                                Text(
                                  "AMOUNT RETURNED",
                                  style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "ETB ${widget.order?.totalAmount.toStringAsFixed(2) ?? '110.00'}",
                                  style: AppTextStyles.heading(color: AppColors.textPrimary).copyWith(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                
                                // Row details
                                _buildDetailRow("Method", widget.order?.paymentMethod ?? "Telebirr"),
                                const SizedBox(height: 16),
                                _buildDetailRow(
                                  "Items Returned", 
                                  widget.order != null && widget.order!.items.isNotEmpty 
                                      ? "${widget.order!.items.length}x ${widget.order!.items.first.product.name}"
                                      : "1x Habesha Beer", 
                                  detail: widget.order != null && widget.order!.items.isNotEmpty && widget.order!.items.length > 1 
                                      ? "+${widget.order!.items.length - 1} more items"
                                      : "(Bottle)",
                                ),
                                
                                const SizedBox(height: 32),
                                // Authorized by Block
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F6FC), // Light blue-grey
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "AUTHORIZED BY: MANAGER #04",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 32),
                          // Buttons
                          CustomButton(
                            text: "SEND DIGITAL COPY",
                            icon: Icons.send_outlined,
                            iconLeading: true,
                            backgroundColor: Colors.transparent,
                            textColor: AppColors.primary,
                            borderColor: AppColors.primary,
                            borderWidth: 1.5,
                            onPressed: () async {
                              if (widget.order != null) {
                                await ReceiptHelper.shareReceipt(
                                  orderId: widget.order!.id,
                                  orderDate: widget.order!.orderDate,
                                  totalAmount: widget.order!.totalAmount,
                                  signatureImage: null,
                                  title: 'REFUND DIGITAL RECEIPT',
                                );
                              }
                            },
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: "PRINT REFUND RECEIPT", 
                            icon: Icons.print_outlined,
                            iconLeading: true,
                            backgroundColor: AppColors.primary,
                            textColor: Colors.white,
                            onPressed: () async {
                              if (widget.order != null) {
                                await ReceiptHelper.generateAndDownloadReceipt(
                                  orderId: widget.order!.id,
                                  orderDate: widget.order!.orderDate,
                                  totalAmount: widget.order!.totalAmount,
                                  signatureImage: null,
                                  title: 'REFUND RECEIPT',
                                );
                              }
                            },
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {String? detail}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.subHeading(color: AppColors.textPrimary).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
            if (detail != null)
              Text(
                detail,
                textAlign: TextAlign.right,
                style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                  fontSize: 11,
                ),
              ),
          ],
        )
      ],
    );
  }
}
