import 'package:flutter/material.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/custom_search.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/refund_card.dart';
import '../../shared/widgets/footer.dart';
import '../../core/theme/app_colors.dart';
import '../../services/transaction_service.dart';
import 'package:intl/intl.dart';
import '../../models/order_model.dart';
import '../../core/routes/app_routes.dart';

class RefundScreen extends StatefulWidget {
  const RefundScreen({super.key});

  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  int _selectedRefundIndex = 0; // The first item is selected in the image

  List<Order> _transactions = [];

  @override
  void initState() {
    super.initState();
    _transactions = TransactionService().getRecentTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopBar(
        title: 'REFUND',
        showStatus: false,
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          Navigator.pop(context);
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '|',
              style: TextStyle(
                color: Colors.grey.withOpacity(0.4),
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            TextButton(
              onPressed: () {
                // Clear action logic here
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'CLEAR',
                style: TextStyle(
                  color: Color(0xFFE94E2A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
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
            child: _transactions.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 64, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text(
                        'No recent transactions found',
                        style: TextStyle(color: Colors.grey[500], fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                return RefundCard(
                  orderId: transaction.id,
                  amount: transaction.totalAmount,
                  paymentMethod: transaction.paymentMethod,
                  time: DateFormat('hh:mm a').format(transaction.orderDate),
                  isSelected: _selectedRefundIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedRefundIndex = index;
                    });
                    
                    // Navigate to Refund Auth
                    Navigator.pushNamed(
                      context,
                      AppRoutes.refundAuth,
                      arguments: {'order': transaction},
                    );
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
