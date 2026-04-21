import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/footer.dart';

class ErrorRefundScreen extends StatefulWidget {
  const ErrorRefundScreen({super.key});

  @override
  State<ErrorRefundScreen> createState() => _ErrorRefundScreenState();
}

class _ErrorRefundScreenState extends State<ErrorRefundScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FC),
      body: Column(
        children: [
          // Top Red Header
          Container(
            width: double.infinity,
            color: const Color(0xFFE03F22), // Closely matches the vibrant red in the design
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 40,
              bottom: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Error Icon Container
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "REFUND FAILED",
                  style: AppTextStyles.heading(color: Colors.white).copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Reference: #RF-ERR-503",
                  style: AppTextStyles.body(color: Colors.white.withOpacity(0.9)).copyWith(
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Main Error Details Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  // Error Details Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE03F22).withOpacity(0.7),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              color: Color(0xFFE03F22),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "UNABLE TO PROCESS RETURN",
                                style: AppTextStyles.heading(color: AppColors.textPrimary).copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Error Description
                        Text(
                          "Manager PIN accepted, but the Telebirr gateway timed out. No funds have been moved.",
                          style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Error Code Tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE03F22).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "ERROR CODE: GATEWAY_TIMEOUT",
                            style: AppTextStyles.body(color: const Color(0xFFE03F22)).copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  CustomButton(
                    text: "RETRY PROCESSING",
                    icon: Icons.refresh_rounded,
                    iconLeading: true,
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                    mainAxisAlignment: MainAxisAlignment.center,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  
                  CustomButton(
                    text: "BACK TO DASHBOARD",
                    backgroundColor: Colors.white,
                    textColor: AppColors.primary,
                    borderColor: AppColors.border, // Looks like a subtle silver/light blue border in design
                    borderWidth: 1.5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  
                  CustomButton(
                    text: "CANCEL",
                    icon: Icons.close_rounded,
                    iconLeading: true,
                    backgroundColor: Colors.white,
                    textColor: const Color(0xFFE03F22),
                    iconColor: const Color(0xFFE03F22),
                    borderColor: const Color(0xFFE03F22).withOpacity(0.7),
                    borderWidth: 1.5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 24),
                ],
              ),
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
}
