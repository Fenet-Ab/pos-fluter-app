import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/footer.dart';
import 'auth_screen.dart';

class CbeBirrScreen extends StatefulWidget {
  final double totalAmount;

  const CbeBirrScreen({super.key, required this.totalAmount});

  @override
  State<CbeBirrScreen> createState() => _CbeBirrScreenState();
}

class _CbeBirrScreenState extends State<CbeBirrScreen> {
  int _selectedIndex = 0;
  bool _isProcessing = false;
  late final TextEditingController _accountController;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
  }

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const cbePurple = Color(0xFF4A148C);
    const cbeYellow = Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "CBE BIRR",
          style: AppTextStyles.subHeading(color: AppColors.primary).copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _accountController.clear();
                _errorMessage = null;
                _isProcessing = false;
              });
            },
            child: Text(
              "CLEAR",
              style: AppTextStyles.subHeading(color: AppColors.error).copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.error, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: AppTextStyles.body(color: AppColors.error).copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        children: [
                          // Total Card
                          TotalCard(
                            title: "TOTAL AMOUNT",
                            value: "ETB ${widget.totalAmount.toStringAsFixed(2)}",
                            height: 90,
                          ),
                          const SizedBox(height: 32),

                          // QR Scanner Section
                          Text(
                            "Scan Customer's CBE Birr QR Code",
                            style: AppTextStyles.body(color: AppColors.textPrimary).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // QR Scanner Graphic
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFF),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: cbePurple, width: 1.5),
                            ),
                            child: Stack(
                              children: [
                                // Corners
                                Positioned(top: 16, left: 16, child: _buildScannerCorner(isTop: true, isLeft: true, color: cbePurple)),
                                Positioned(top: 16, right: 16, child: _buildScannerCorner(isTop: true, isLeft: false, color: cbePurple)),
                                Positioned(bottom: 16, left: 16, child: _buildScannerCorner(isTop: false, isLeft: true, color: cbePurple)),
                                Positioned(bottom: 16, right: 16, child: _buildScannerCorner(isTop: false, isLeft: false, color: cbePurple)),

                                // Center Icon/Graphic
                                Center(
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    color: const Color(0xFF8A94A6), // Grey placeholder block
                                    child: Center(
                                      child: Text(
                                        "CBE",
                                        style: AppTextStyles.heading(color: Colors.white).copyWith(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Scan Line
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    width: double.infinity,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: cbeYellow,
                                      boxShadow: [
                                        BoxShadow(
                                          color: cbeYellow.withOpacity(0.5),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                          // OR Divider
                          Row(
                            children: [
                              Expanded(child: Divider(color: AppColors.border.withOpacity(0.5))),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9EEFF),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "OR",
                                  style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Expanded(child: Divider(color: AppColors.border.withOpacity(0.5))),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Manual Phone/Account Entry
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ENTER ACCOUNT NUMBER",
                                style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                constraints: const BoxConstraints(minHeight: 50),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9EEFF), // Light blue container
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.account_balance_wallet_outlined, // Wallet icon
                                      color: cbePurple,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: _accountController,
                                        keyboardType: TextInputType.phone,
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
                                          hintText: "Enter Account or Phone (09...)",
                                          hintStyle: AppTextStyles.body(color: const Color(0xFF8A94A6)).copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        style: AppTextStyles.body(color: AppColors.textPrimary).copyWith(
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
                          const SizedBox(height: 48),

                          // Loading / Status row
                          if (_isProcessing)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(cbePurple),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Waiting for CBE Birr confirmation...",
                                  style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 24),
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
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: CustomButton(
                          text: "COMPLETE",
                          backgroundColor: const Color(0xFF1B8B41), // Rich green matching the design
                          textColor: Colors.white,
                          mainAxisAlignment: MainAxisAlignment.center,
                          onPressed: () {
                            if (_accountController.text.isEmpty) {
                              setState(() {
                                _errorMessage = "ENTER ACCOUNT NUMBER";
                              });
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthScreen(
                                  orderId: "#SAV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}-EP",
                                  orderDate: DateTime.now(),
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

  Widget _buildScannerCorner({required bool isTop, required bool isLeft, required Color color}) {
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
