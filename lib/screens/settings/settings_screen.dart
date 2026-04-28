import 'package:flutter/material.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/footer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/sidebar.dart';
import '../../core/navigation/navigation_items.dart';
import '../../shared/widgets/setting_card.dart';
import '../../core/routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomTopBar(
        title: 'SETTINGS',
        status: 'ONLINE',
        showTrailingIcon: true,
      ),
      drawer: Sidebar(
        selectedId: 'settings',
        items: NavigationItems.mainItems(context, activeId: 'settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Internal Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
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
                    "Settings",
                    style: AppTextStyles.heading(
                      color: AppColors.textPrimary,
                    ).copyWith(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    width: 44,
                  ), // Empty space to balance the back button
                ],
              ),
            ),

            // Scrollable Content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    SettingCard(
                      icon: Icons.person_outline_rounded,
                      title: "User Management",
                      subtitle: "Manage staff, roles and permissions",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.userManagement,
                        );
                      },
                    ),
                    SettingCard(
                      icon: Icons.print_outlined,
                      title: "Printer Settings",
                      subtitle: "Configure receipt and kitchen printers",
                      onTap: () {},
                    ),
                    SettingCard(
                      icon: Icons.business_outlined,
                      title: "Business Info",
                      subtitle: "Update store name, logo and address",
                      onTap: () {},
                    ),
                    SettingCard(
                      icon: Icons.security_outlined,
                      title: "Security & PIN",
                      subtitle: "Change access pins and security levels",
                      onTap: () {},
                    ),
                    SettingCard(
                      icon: Icons.help_outline_rounded,
                      title: "Help & Support",
                      subtitle: "Get assistance and view tutorials",
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),

                    // Logout Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.login,
                            (route) => false,
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.error,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.logout_rounded),
                            SizedBox(width: 12),
                            Text(
                              "LOGOUT",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
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
