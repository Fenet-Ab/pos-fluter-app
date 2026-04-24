import 'package:flutter/material.dart';
import 'package:pos_application/screens/cart/cart_sale.dart';
import 'package:pos_application/screens/refund/refund_screen.dart';
import 'package:pos_application/models/cart_model.dart';
import 'package:pos_application/screens/settings/settings_screen.dart';
import 'package:pos_application/screens/user_management/user_management_screen.dart';
import '../../shared/widgets/footer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/sidebar.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/custom_card.dart';
import '../../core/navigation/navigation_items.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/custom_button.dart';
import '../sales/sales_screen.dart';
import '../transaction/transaction_history_screen.dart';
import '../reports/reports_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: const CustomTopBar(),
      drawer: Sidebar(
        selectedId: 'dashboard',
        items: NavigationItems.mainItems(context, activeId: 'dashboard'),
        onItemSelected: (item) {
          // Handle navigation
        },
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Text
              Center(
                child: Text(
                  "Welcome, Cashier 01",
                  style: AppTextStyles.body().copyWith(
                    color: const Color(0xFF8E92A8),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Start New Sale Button
              CustomButton(
                text: "START NEW SALE",
                icon: Icons.add,
                iconLeading: true,
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SalesScreen(),
                    ),
                  );
                },
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                height: 62,
              ),
              const SizedBox(height: 32),

              // Today's Revenue & Active Orders Row
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: TotalCard(
                        title: "TODAY'S REVENUE",
                        value: "ETB 1,240.00",
                        backgroundColor: Colors.white,
                        valueColor: AppColors.success,
                        borderColor: AppColors.secondary.withOpacity(
                          0.2,
                        ), // Now supported!
                        borderWidth: 1.0,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TotalCard(
                        title: "ACTIVE ORDERS",
                        value: "12",
                        backgroundColor: Colors.white,
                        valueColor: AppColors.success,
                        borderColor: AppColors.secondary.withOpacity(
                          0.2,
                        ), // Now supported!
                        borderWidth: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Actions Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
                children: [
                  CustomCard(
                    icon: Icons.receipt_long_rounded,
                    title: "SALES HISTORY",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TransactionHistoryScreen(),
                        ),
                      );
                    },
                  ),
                  CustomCard(
                    icon: Icons.bar_chart_rounded,
                    title: "REPORTS",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportsScreen(),
                        ),
                      );
                    },
                  ),
                  CustomCard(
                    icon: Icons.inventory_2_outlined,
                    title: "ITEMS & STOCK",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartSaleScreen(cartItems: <CartItem>[]),
                        ),
                      );
                    },
                  ),
                  CustomCard(
                    icon: Icons.reply_rounded,
                    title: "REFUND",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RefundScreen(),
                        ),
                      );
                    },
                  ),
                  CustomCard(
                    icon: Icons.person_rounded,
                    title: "USERS",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserManagementScreen(),
                        ),
                      );
                    },
                  ),
                  CustomCard(
                    icon: Icons.settings_outlined,
                    title: "SETTINGS",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
