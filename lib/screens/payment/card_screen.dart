import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/footer.dart';
import 'auth_screen.dart';
import '../../models/cart_model.dart';

class CardScreen extends StatefulWidget {
  final double totalAmount;
  final List<CartItem> cartItems;

  const CardScreen({
    super.key,
    required this.totalAmount,
    this.cartItems = const [],
  });

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int _selectedIndex = 0;
  bool _isProcessing = false;
  final TextEditingController _cardNumberController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _cardNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const frameColor = Color(
      0xFF4A148C,
    ); // Using the dark purple from CBE for the frame

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "BANK CARD",
              style: AppTextStyles.subHeading(
                color: AppColors.primary,
              ).copyWith(fontWeight: FontWeight.w900, fontSize: 14),
            ),
            const SizedBox(width: 10),
            Container(width: 1, height: 16, color: AppColors.border),
            const SizedBox(width: 2),
            TextButton(
              onPressed: () {
                setState(() {
                  _cardNumberController.clear();
                  _isProcessing = false;
                  _errorMessage = null;
                });
              },
              child: Text(
                "CLEAR",
                style: AppTextStyles.subHeading(
                  color: AppColors.error,
                ).copyWith(fontWeight: FontWeight.w900, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: AppTextStyles.body(
                            color: AppColors.error,
                          ).copyWith(fontWeight: FontWeight.w900, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          // Total Card
                          TotalCard(
                            title: "AMOUNT RECEIVED",
                            value:
                                "ETB ${widget.totalAmount.toStringAsFixed(2)}",
                            height: 90,
                          ),
                          const SizedBox(height: 32),

                          // Card Reader Section
                          Text(
                            "Swipe, Insert or Tap Card on Terminal",
                            style:
                                AppTextStyles.body(
                                  color: AppColors.textPrimary,
                                ).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 16),

                          // Graphic Frame
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: frameColor, width: 1.5),
                            ),
                            child: Stack(
                              children: [
                                // Corners
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  child: _buildScannerCorner(
                                    isTop: true,
                                    isLeft: true,
                                    color: frameColor,
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: _buildScannerCorner(
                                    isTop: true,
                                    isLeft: false,
                                    color: frameColor,
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: _buildScannerCorner(
                                    isTop: false,
                                    isLeft: true,
                                    color: frameColor,
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  right: 16,
                                  child: _buildScannerCorner(
                                    isTop: false,
                                    isLeft: false,
                                    color: frameColor,
                                  ),
                                ),

                                // Center Wallet/Card Icon
                                Center(
                                  child: Icon(
                                    Icons.account_balance_wallet_rounded,
                                    size: 100,
                                    color: const Color(
                                      0xFFFF9800,
                                    ), // Orange color matching design
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                          // OR Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.border.withOpacity(0.5),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9EEFF),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "OR",
                                  style:
                                      AppTextStyles.body(
                                        color: AppColors.textSecondary,
                                      ).copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.border.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Manual Card Entry
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ENTER CARD NUMBER",
                                style:
                                    AppTextStyles.body(
                                      color: AppColors.textSecondary,
                                    ).copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.0,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                constraints: const BoxConstraints(
                                  minHeight: 60,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFE9EEFF,
                                  ), // Light blue container
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.credit_card_outlined,
                                      color: AppColors.textSecondary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: _cardNumberController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (text) {
                                          setState(() {
                                            _isProcessing = text.isNotEmpty;
                                            if (text.isNotEmpty) {
                                              _errorMessage = null;
                                            }
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "Enter Card Number Manually (Last Resort)",
                                          hintMaxLines: 2,
                                          hintStyle:
                                              AppTextStyles.body(
                                                color: const Color(0xFF8A94A6),
                                              ).copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        style:
                                            AppTextStyles.body(
                                              color: AppColors.textPrimary,
                                            ).copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Processing status block
                          if (_isProcessing)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFF2F5FF,
                                ), // Very soft blue block
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "PROCESSING SECURE PAYMENT...",
                                    style:
                                        AppTextStyles.subHeading(
                                          color: AppColors.primary,
                                        ).copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "DO NOT REMOVE CARD",
                                    style:
                                        AppTextStyles.body(
                                          color: AppColors.textSecondary,
                                        ).copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action Area
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),
                        child: CustomButton(
                          text: "COMPLETE",
                          backgroundColor: const Color(
                            0xFF1B8B41,
                          ), // Rich green matching the design
                          textColor: Colors.white,
                          mainAxisAlignment: MainAxisAlignment.center,
                          onPressed: () {
                            if (_cardNumberController.text.isEmpty) {
                              setState(() {
                                _errorMessage = "ENTER CARD NUMBER";
                              });
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthScreen(
                                  orderId:
                                      "#SAV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}-EP",
                                  orderDate: DateTime.now(),
                                  totalAmount: widget.totalAmount,
                                  paymentMethod: "Bank Card",
                                  cartItems: widget.cartItems,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildScannerCorner({
    required bool isTop,
    required bool isLeft,
    required Color color,
  }) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? BorderSide(color: color, width: 3) : BorderSide.none,
          bottom: !isTop ? BorderSide(color: color, width: 3) : BorderSide.none,
          left: isLeft ? BorderSide(color: color, width: 3) : BorderSide.none,
          right: !isLeft ? BorderSide(color: color, width: 3) : BorderSide.none,
        ),
      ),
    );
  }
}
