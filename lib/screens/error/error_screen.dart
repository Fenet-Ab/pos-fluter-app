import 'package:flutter/material.dart';
import '../../shared/widgets/custom_button.dart';
import '../../core/theme/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF), // Light background color for the screen
      body: Column(
        children: [
          // Custom Red Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFC62828), // Deep Red
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Icon(Icons.close, color: Colors.white, size: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PAYMENT FAILED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Error Code: #ERR-902 (Insufficient Funds)',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Body Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Error Details Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.red.withOpacity(0.2),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.mobile_off,
                            color: Color(0xFFC62828),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Error Text Area
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "The customer's Telebirr account does not have enough balance for this transaction.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF1E283C), // Navy bold text
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Please ask the customer to use another payment method or top up their wallet.",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Retry Transaction Button
                  CustomButton(
                    text: 'RETRY TRANSACTION',
                    icon: Icons.refresh_rounded,
                    iconLeading: true,
                    mainAxisAlignment: MainAxisAlignment.center,
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primary,
                    textColor: AppColors.primary,
                    iconColor: AppColors.primary,
                    onPressed: () {
                      // Handle retry
                    },
                  ),
                  
                  const SizedBox(height: 16),

                  // Change Payment Method Button
                  CustomButton(
                    text: 'CHANGE PAYMENT METHOD',
                    icon: Icons.payments_outlined,
                    iconLeading: true,
                    mainAxisAlignment: MainAxisAlignment.center,
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primary,
                    textColor: AppColors.primary,
                    iconColor: AppColors.primary,
                    onPressed: () {
                      // Navigate to payment methods
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Footer
      bottomNavigationBar: Container(
        color: const Color(0xFF1A263E), // Dark blue background for bottom
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: SafeArea(
          child: Row(
            children: [
              // Cancel Button
              Expanded(
                flex: 1,
                child: CustomButton(
                  width: null, // Allow it to flex
                  text: 'CANCEL',
                  icon: Icons.close_rounded,
                  iconLeading: true,
                  mainAxisAlignment: MainAxisAlignment.center,
                  backgroundColor: Colors.transparent, // to show the dark blue background
                  borderColor: const Color(0xFFE94E2A), // Red orange outline
                  textColor: const Color(0xFFE94E2A),
                  iconColor: const Color(0xFFE94E2A),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Back to Cart Button
              Expanded(
                flex: 1,
                child: CustomButton(
                  width: null, // Allow it to flex
                  text: 'BACK TO CART',
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Background color defaults to AppColors.primary (blue)
                  onPressed: () {
                    // Navigate back to cart
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
