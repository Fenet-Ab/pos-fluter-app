import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/footer.dart';

class TelebirrScreen extends StatefulWidget {
  const TelebirrScreen({super.key});

  @override
  State<TelebirrScreen> createState() => _TelebirrScreenState();
}

class _TelebirrScreenState extends State<TelebirrScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFF), // Slight tint
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
              "TELEBIRR",
              style: AppTextStyles.subHeading(color: AppColors.primary).copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 1,
              height: 16,
              color: AppColors.border,
            ),
            const SizedBox(width: 2),
            TextButton(
              onPressed: () {
                // Clear action
              },
              child: Text(
                "CLEAR",
                style: AppTextStyles.subHeading(color: AppColors.error).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      // Total Card
                      const TotalCard(
                        title: "TOTAL AMOUNT",
                        value: "ETB 440.00",
                        height: 90,
                      ),
                      const SizedBox(height: 32),

                      // QR Scanner Section
                      Text(
                        "Point customer's QR code at the camera",
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
                          color: const Color(0xFFE9EEFF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Stack(
                          children: [
                            // Corners
                            Positioned(top: 0, left: 0, child: _buildScannerCorner(isTop: true, isLeft: true)),
                            Positioned(top: 0, right: 0, child: _buildScannerCorner(isTop: true, isLeft: false)),
                            Positioned(bottom: 0, left: 0, child: _buildScannerCorner(isTop: false, isLeft: true)),
                            Positioned(bottom: 0, right: 0, child: _buildScannerCorner(isTop: false, isLeft: false)),
                            
                            // Center Icon
                            Center(
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                size: 50,
                                color: const Color(0xFF00B2FF).withOpacity(0.3),
                              ),
                            ),

                            // Scan Line
                            Center(
                              child: Container(
                                width: double.infinity,
                                height: 2,
                                color: const Color(0xFF00B2FF),
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

                      // Manual Phone Entry
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MANUAL PHONE NUMBER ENTRY",
                            style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9EEFF), // Light blue container
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.phone_android_outlined,
                                  color: AppColors.textSecondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Phone (e.g. 0912...)",
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
                      const SizedBox(height: 40),

                      // Loading / Status text
                      Column(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Waiting for customer to confirm\non their phone...",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom Action Area
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: CustomButton(
                text: "COMPLETE",
                backgroundColor: const Color(0xFF1B8B41), // Rich green matching the design
                textColor: Colors.white,
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: () {},
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

  Widget _buildScannerCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: Color(0xFF00B2FF), width: 4) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: Color(0xFF00B2FF), width: 4) : BorderSide.none,
          left: isLeft ? const BorderSide(color: Color(0xFF00B2FF), width: 4) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: Color(0xFF00B2FF), width: 4) : BorderSide.none,
        ),
      ),
    );
  }
}
