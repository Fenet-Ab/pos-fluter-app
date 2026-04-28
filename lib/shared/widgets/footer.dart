import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/routes/app_routes.dart';

/// A reusable footer (bottom navigation bar) component for the SAVVY POS system.
///
/// This component displays a set of navigation icons and highlights the active one
/// using the theme's primary color.
class CustomFooter extends StatelessWidget {
  /// The index of the currently selected item.
  final int selectedIndex;

  /// Callback when an item is selected.
  final Function(int) onItemSelected;

  const CustomFooter({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  void _handleNavigation(BuildContext context, int index) {
    if (index == selectedIndex) return;

    String routeName;
    switch (index) {
      case 0:
        routeName = AppRoutes.dashboard;
        break;
      case 1:
        routeName = AppRoutes.transactionHistory;
        break;
      case 2:
        routeName = AppRoutes.reports;
        break;
      case 3:
        routeName = AppRoutes.settings;
        break;
      default:
        return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _FooterItem(
                icon: Icons.home_rounded,
                isActive: selectedIndex == 0,
                onTap: () {
                  onItemSelected(0);
                  _handleNavigation(context, 0);
                },
              ),
              _FooterItem(
                icon: Icons.receipt_long_rounded,
                isActive: selectedIndex == 1,
                onTap: () {
                  onItemSelected(1);
                  _handleNavigation(context, 1);
                },
              ),
              _FooterItem(
                icon: Icons.bar_chart_rounded,
                isActive: selectedIndex == 2,
                onTap: () {
                  onItemSelected(2);
                  _handleNavigation(context, 2);
                },
              ),
              _FooterItem(
                icon: Icons.settings_rounded,
                isActive: selectedIndex == 3,
                onTap: () {
                  onItemSelected(3);
                  _handleNavigation(context, 3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _FooterItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Icon(
          icon,
          size: 28,
          color: isActive ? AppColors.primary : const Color(0xFF434654),
        ),
      ),
    );
  }
}
