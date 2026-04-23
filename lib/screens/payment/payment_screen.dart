import 'package:flutter/material.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/custom_card.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/footer.dart';
import '../../core/theme/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0; // 0 for CASH by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopBar(
        title: 'PAYMENT METHOD',
        showStatus: false,
        leadingIcon: Icons.arrow_back,
        showTrailingIcon: true,
        trailingIcon: Icons.person,
        onLeadingTap: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          // Total Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TotalCard(
              title: 'TOTAL',
              value: 'ETB 440.00',
            ),
          ),

          // Payment Methods Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1, // Keeping cards slightly squarish
              children: [
                _buildPaymentOption(
                  index: 0,
                  icon: Icons.account_balance_wallet,
                  title: 'CASH',
                ),
                _buildPaymentOption(
                  index: 1,
                  icon: Icons.mobile_screen_share,
                  title: 'TELEBIRR',
                ),
                _buildPaymentOption(
                  index: 2,
                  icon: Icons.account_balance,
                  title: 'CBE BIRR',
                ),
                _buildPaymentOption(
                  index: 3,
                  icon: Icons.credit_card,
                  title: 'BANK CARD',
                ),
              ],
            ),
          ),

          // Cancel Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: CustomButton(
              text: 'CANCEL',
              icon: Icons.close_rounded,
              iconLeading: true,
              mainAxisAlignment: MainAxisAlignment.center,
              backgroundColor: Colors.white,
              borderColor: const Color(0xFFE94E2A), // Matching the red outline in the image
              textColor: const Color(0xFFE94E2A),
              iconColor: const Color(0xFFE94E2A),
              onPressed: () {
                // Cancel Action
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: 1, // Usually the receipt or another relevant tab depending on flow
        onItemSelected: (index) {
          // Footer Navigation Logic
        },
      ),
    );
  }

  Widget _buildPaymentOption({
    required int index,
    required IconData icon,
    required String title,
  }) {
    bool isSelected = _selectedPaymentMethod == index;
    return CustomCard(
      icon: icon,
      title: title,
      borderColor: isSelected ? AppColors.primary : AppColors.border.withOpacity(0.5),
      borderWidth: isSelected ? 1.5 : 1.0,
      onTap: () {
        setState(() {
          _selectedPaymentMethod = index;
        });
      },
    );
  }
}
