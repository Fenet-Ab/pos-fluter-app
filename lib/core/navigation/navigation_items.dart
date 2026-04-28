import 'package:flutter/material.dart';
import 'package:pos_application/screens/cart/cart_sale.dart';
import '../../shared/widgets/sidebar.dart';
import '../../screens/dashboard/dashboard_screen.dart';

import '../../screens/sales/sales_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/user_management/user_management_screen.dart';

class NavigationItems {
  static List<SidebarItem> mainItems(
    BuildContext context, {
    required String? activeId,
  }) {
    return [
      SidebarItem(
        id: 'dashboard',
        icon: Icons.dashboard_outlined,
        title: 'Dashboard',
        onTap: () {
          if (activeId == 'dashboard') {
            Navigator.pop(context);
            return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
            (route) => false,
          );
        },
      ),
      SidebarItem(
        id: 'orders',
        icon: Icons.shopping_cart_outlined,
        title: 'Orders',
        onTap: () {
          if (activeId == 'orders') {
            Navigator.pop(context);
            return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const CartSaleScreen(cartItems: []),
            ),
            (route) => false,
          );
        },
      ),
      SidebarItem(
        id: 'products',
        icon: Icons.inventory_2_outlined,
        title: 'Products',
        onTap: () {
          if (activeId == 'products') {
            Navigator.pop(context);
            return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SalesScreen()),
            (route) => false,
          );
        },
      ),
      SidebarItem(
        id: 'users',
        icon: Icons.people_outline,
        title: 'User Management',
        onTap: () {
          if (activeId == 'users') {
            Navigator.pop(context);
            return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const UserManagementScreen(),
            ),
            (route) => false,
          );
        },
      ),
      SidebarItem(
        id: 'settings',
        icon: Icons.settings_outlined,
        title: 'Settings',
        onTap: () {
          if (activeId == 'settings') {
            Navigator.pop(context);
            return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
            (route) => false,
          );
        },
      ),
    ];
  }
}
