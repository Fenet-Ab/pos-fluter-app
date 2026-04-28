import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/reports_card.dart';
import '../../shared/widgets/footer.dart';
import '../../core/utils/report_helper.dart';
import '../../core/routes/app_routes.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _selectedIndex = 2; // Active tab for reports is typically chart (index 2)
  String _activeFilter = 'Monthly';
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _activeFilter = 'Daily';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Looking at the image, mostly white background
      appBar: CustomTopBar(
        title: 'REPORTS',
        status: 'ONLINE',
        showLeadingIcon: true,
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          if (Navigator.of(context).canPop()) {
            Navigator.pop(context);
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.dashboard,
              (route) => false,
            );
          }
        },
        showTrailingIcon: true,
        titleFontSize: 16,
        itemSpacing: 12,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Secondary AppBar Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.dashboard,
                          (route) => false,
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 28,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    _activeFilter == "Daily"
                        ? DateFormat('dd MMM yyyy').format(_selectedDate)
                        : "Report",
                    style: AppTextStyles.heading(
                      color: AppColors.textPrimary,
                    ).copyWith(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 22,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () => _selectDate(context),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.download_outlined,
                          size: 24,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () => ReportHelper.generateAndDownloadReport(
                          filterType: _activeFilter,
                          selectedDate: _selectedDate,
                          netSales: "ETB 45,820.00",
                          totalRefunds: "ETB 1,200.00",
                          estProfit: "ETB 8,450.50",
                          paymentMethods: [
                            {
                              'method': 'CASH IN TILL',
                              'amount': 'ETB 12,300.00'
                            },
                            {
                              'method': 'TELEBIRR PAYMENTS',
                              'amount': 'ETB 22,450.00'
                            },
                            {
                              'method': 'CBE BIRR PAYMENTS',
                              'amount': 'ETB 11,070.00'
                            },
                          ],
                          topProducts: [
                            {
                              'name': 'Habesha Beer',
                              'sku': 'HB-0042',
                              'quantity': '142'
                            },
                            {
                              'name': 'Arki Water',
                              'sku': 'AW-0912',
                              'quantity': '88'
                            },
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Filter Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTab(
                    "Daily",
                    _activeFilter == "Daily",
                    () => setState(() => _activeFilter = "Daily"),
                  ),
                  const SizedBox(width: 12),
                  _buildTab(
                    "Monthly",
                    _activeFilter == "Monthly",
                    () => setState(() => _activeFilter = "Monthly"),
                  ),
                  const SizedBox(width: 12),
                  _buildTab(
                    "Yearly",
                    _activeFilter == "Yearly",
                    () => setState(() => _activeFilter = "Yearly"),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Net Sales Section
              Text(
                "NET SALES",
                style: AppTextStyles.body(color: AppColors.textSecondary)
                    .copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                "ETB 45,820.00",
                style: AppTextStyles.heading(
                  color: AppColors.textPrimary,
                ).copyWith(fontSize: 28, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.trending_up_rounded,
                    color: AppColors.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "+12.4% vs yesterday",
                    style: AppTextStyles.body(
                      color: AppColors.primary,
                    ).copyWith(fontSize: 12, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Total Refunds Card
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD43B00), // Dark orange
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TOTAL REFUNDS",
                                style:
                                    AppTextStyles.body(
                                      color: AppColors.textSecondary,
                                    ).copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "ETB 1,200.00",
                                style:
                                    AppTextStyles.heading(
                                      color: const Color(0xFFD43B00),
                                    ).copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    size: 16,
                                    color: Color(0xFFD43B00),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "High frequency alert",
                                    style:
                                        AppTextStyles.body(
                                          color: const Color(0xFFD43B00),
                                        ).copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Estimated Profit Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EST. PROFIT",
                      style:
                          AppTextStyles.body(
                            color: Colors.white.withOpacity(0.8),
                          ).copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "ETB 8,450.50",
                      style: AppTextStyles.heading(
                        color: Colors.white,
                      ).copyWith(fontSize: 28, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.white.withOpacity(0.9),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "On track for monthly goal",
                          style: AppTextStyles.body(
                            color: Colors.white.withOpacity(0.9),
                          ).copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Reconciliation Zone Header
              Row(
                children: [
                  const Icon(
                    Icons.pie_chart_outline,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "RECONCILIATION ZONE",
                    style: AppTextStyles.heading(
                      color: AppColors.textPrimary,
                    ).copyWith(fontSize: 12, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Reconciliation zone wrapper to match design (grey container with simple list)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    const ReportsCard(
                      title: 'CASH IN TILL',
                      amount: 12300.00,
                      type: 'CASH',
                    ),
                    const ReportsCard(
                      title: 'TELEBIRR PAYMENTS',
                      amount: 22450.00,
                      type: 'TELEBIRR',
                    ),
                    const ReportsCard(
                      title: 'CBE BIRR PAYMENTS',
                      amount: 11070.00,
                      type: 'CBEBIRR',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Top Selling Products Header
              Row(
                children: [
                  const Icon(
                    Icons.stars_rounded,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "TOP SELLING PRODUCTS",
                    style: AppTextStyles.heading(
                      color: AppColors.textPrimary,
                    ).copyWith(fontSize: 12, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Top Selling Products List
              _buildProductItem(
                "Habesha Beer",
                "SKU: HB-0042",
                "142 Sold",
                "TOP VOLUME",
                Icons.sports_bar_outlined,
              ),
              const SizedBox(height: 12),
              _buildProductItem(
                "Arki Water",
                "SKU: AW-0912",
                "88 Sold",
                "STEADY DEMAND",
                Icons.water_drop_outlined,
              ),
              const SizedBox(height: 32),
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

  Widget _buildTab(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isActive
              ? null
              : Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Text(
          text,
          style:
              AppTextStyles.body(
                color: isActive ? Colors.white : AppColors.textPrimary,
              ).copyWith(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Widget _buildProductItem(
    String name,
    String sku,
    String amount,
    String status,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE9EEFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.heading(
                    color: AppColors.textPrimary,
                  ).copyWith(fontSize: 14, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  sku,
                  style: AppTextStyles.body(
                    color: AppColors.textSecondary,
                  ).copyWith(fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: AppTextStyles.heading(
                  color: AppColors.textPrimary,
                ).copyWith(fontSize: 14, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style:
                    AppTextStyles.body(
                      color: status == 'TOP VOLUME'
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ).copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
