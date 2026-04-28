import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/custom_search.dart';
import '../../shared/widgets/sales_history_card.dart';
import '../../shared/widgets/footer.dart';
import '../../services/transaction_service.dart';
import '../../models/order_model.dart';
import 'package:intl/intl.dart';
import '../../shared/widgets/sidebar.dart';
import '../../core/navigation/navigation_items.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  int _selectedIndex = 1;
  List<Order> _transactions = [];

  double get _totalSales => _transactions
      .where((o) => o.status.toLowerCase() == 'completed')
      .fold(0, (sum, item) => sum + item.totalAmount);

  double get _totalRefunds => _transactions
      .where((o) => o.status.toLowerCase() == 'refunded')
      .fold(0, (sum, item) => sum + item.totalAmount);

  double get _cashInTill => _transactions
      .where(
        (o) =>
            o.paymentMethod.toLowerCase() == 'cash' &&
            o.status.toLowerCase() == 'completed',
      )
      .fold(0, (sum, item) => sum + item.totalAmount);

  @override
  Widget build(BuildContext context) {
    // Refresh transactions from service on every build to ensure latest state
    _transactions = TransactionService().getRecentTransactions();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      appBar: const CustomTopBar(
        title: 'TRANSACTIONS',
        status: 'ONLINE',
        showTrailingIcon: true,
        titleFontSize: 16,
        itemSpacing: 12,
      ),
      drawer: Sidebar(
        selectedId: 'orders',
        items: NavigationItems.mainItems(context, activeId: 'orders'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              const CustomSearch(hintText: 'Search by ID, Phone, or Amount...'),
              const SizedBox(height: 24),

              // Summary Cards
              _SummaryCard(
                title: 'TOTAL SALES',
                amount: 'ETB ${NumberFormat('#,##0.00').format(_totalSales)}',
                accentColor: AppColors.primary,
                amountColor: AppColors.textPrimary,
              ),
              _SummaryCard(
                title: 'TOTAL REFUNDS',
                amount: 'ETB ${NumberFormat('#,##0.00').format(_totalRefunds)}',
                accentColor: const Color(0xFFFF9800), // Orange
                amountColor: const Color(0xFFFF9800),
              ),
              _SummaryCard(
                title: 'CASH IN TILL',
                amount: 'ETB ${NumberFormat('#,##0.00').format(_cashInTill)}',
                accentColor: AppColors.success,
                amountColor: AppColors.success,
              ),

              const SizedBox(height: 24),
              // Date Header
              Text(
                DateFormat(
                  'EEEE, MMMM dd',
                ).format(DateTime.now()).toUpperCase(),
                style: AppTextStyles.body(color: AppColors.textSecondary)
                    .copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 12),

              // Transaction List
              ..._transactions.map(
                (order) => SalesHistoryCard(
                  orderId: order.id,
                  status: order.status.toUpperCase(),
                  time: DateFormat('hh:mm a').format(order.orderDate),
                  itemCount: order.items.length,
                  amount: order.totalAmount,
                  onTap: () {
                    // View Details
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
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
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color accentColor;
  final Color amountColor;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.accentColor,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: AppTextStyles.body(color: AppColors.textSecondary)
                          .copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      amount,
                      style: AppTextStyles.heading(
                        color: amountColor,
                      ).copyWith(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
