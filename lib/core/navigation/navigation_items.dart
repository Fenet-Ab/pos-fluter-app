import 'package:flutter/material.dart';
import '../../shared/widgets/sidebar.dart';
import '../routes/app_routes.dart';

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
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dashboard,
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
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.cart,
            (route) => false,
            arguments: {'cartItems': []},
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
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.sales,
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
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.userManagement,
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
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.settings,
            (route) => false,
          );
        },
      ),
    ];
  }
}
