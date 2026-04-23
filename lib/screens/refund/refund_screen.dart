import 'package:flutter/material.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/custom_search.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/refund_card.dart';
import '../../shared/widgets/footer.dart';
import '../../core/theme/app_colors.dart';

class RefundScreen extends StatefulWidget {
  const RefundScreen({super.key});

  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  int _selectedRefundIndex = 0; // The first item is selected in the image

  final List<Map<String, dynamic>> _recentTransactions = [
    {
      'orderId': '#SAV-94827-EP',
      'amount': 417.45,
      'paymentMethod': 'Telebirr',
      'time': '12:15 PM',
    },
    {
      'orderId': '#SAV-94812-TX',
      'amount': 417.45,
      'paymentMethod': 'Cash',
      'time': '12:15 PM',
    },
    {
      'orderId': '#SAV-94812-TX',
      'amount': 417.45,
      'paymentMethod': 'Cash',
      'time': '12:15 PM',
    },
    {
      'orderId': '#SAV-94812-TX',
      'amount': 417.45,
      'paymentMethod': 'Cash',
      'time': '12:15 PM',
    },
    {
      'orderId': '#SAV-94812-TX',
      'amount': 417.45,
      'paymentMethod': 'Cash',
      'time': '12:15 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopBar(
        title: 'REFUND',
        showStatus: false,
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          Navigator.pop(context);
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 1,
              color: Colors.grey.withOpacity(0.4),
            ),
            TextButton(
              onPressed: () {
                // Clear action
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text(
                'CLEAR',
                style: TextStyle(
                  color: Color(0xFFE94E2A), // Red color seen in the 'CLEAR' text
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Search Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearch(
              hintText: 'Enter Receipt ID or Phone...',
            ),
          ),
          
          const SizedBox(height: 16),

          // Scan QR Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              text: 'SCAN RECEIPT QR',
              icon: Icons.qr_code_scanner,
              iconLeading: true,
              mainAxisAlignment: MainAxisAlignment.center,
              backgroundColor: Colors.white,
              borderColor: AppColors.primary,
              textColor: AppColors.primary,
              iconColor: AppColors.primary,
              onPressed: () {
                // Add QR scan logic
              },
            ),
          ),
          
          const SizedBox(height: 24),

          // Subheader: RECENT TRANSACTIONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RECENT TRANSACTIONS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800, // Matching thick typography style expected
                    color: Color(0xFF5A667B), // Slate Grey text
                    letterSpacing: 0.8,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EEFF), // Pale light blue background
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Last 24 Hours',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5A667B),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Transactions List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _recentTransactions.length,
              itemBuilder: (context, index) {
                final transaction = _recentTransactions[index];
                return RefundCard(
                  orderId: transaction['orderId'],
                  amount: transaction['amount'],
                  paymentMethod: transaction['paymentMethod'],
                  time: transaction['time'],
                  isSelected: _selectedRefundIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedRefundIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: 1, // Highlighting appropriate receipt index
        onItemSelected: (index) {
          // Bottom Navigation Handle
        },
      ),
    );
  }
}
