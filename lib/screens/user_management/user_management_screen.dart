import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/custom_search.dart';
import '../../shared/widgets/user_management_card.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/footer.dart';
import '../../shared/widgets/user_form_dialog.dart';
import '../../shared/widgets/sidebar.dart';
import '../../core/navigation/navigation_items.dart';
import '../../core/routes/app_routes.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  int _selectedIndex = 3; // Settings icon active

  // Dynamic list of users
  final List<Map<String, String>> _users = [
    {
      "name": "Sarah Jenkins",
      "role": "Manager",
      "phone": "0911223344",
      "email": "sarah.j@savvy.com",
    },
    {
      "name": "Mark wilson",
      "role": "Assistant Manager",
      "phone": "0922334455",
      "email": "mark.w@savvy.com",
    },
    {
      "name": "Alice Thomsen",
      "role": "Cashier",
      "phone": "0933445566",
      "email": "alice.t@savvy.com",
    },
    {
      "name": "Tom Harris",
      "role": "Cashier",
      "phone": "0944556677",
      "email": "tom.h@savvy.com",
    },
  ];

  void _showAddUserDialog() {
    UserFormDialog.show(
      context,
      title: "Add New User",
      onSave: (name, role, phone, email) {
        setState(() {
          _users.add({
            "name": name,
            "role": role,
            "phone": phone,
            "email": email,
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User $name added successfully!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  void _updateUser(int index, String name, String role, String phone, String email) {
    setState(() {
      _users[index] = {
        "name": name,
        "role": role,
        "phone": phone,
        "email": email,
      };
    });
  }

  void _deleteUser(int index) {
    if (index < 0 || index >= _users.length) return;
    
    final deletedUser = _users[index]["name"];
    final userCopy = Map<String, String>.from(_users[index]);
    
    setState(() {
      _users.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User $deletedUser deleted'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _users.insert(index, userCopy);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomTopBar(
        title: 'USER MANAGEMENT',
        status: 'ONLINE',
        showTrailingIcon: true,
      ),
      drawer: Sidebar(
        selectedId: 'users',
        items: NavigationItems.mainItems(context, activeId: 'users'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Internal Header - Responsive Handling
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
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
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.chevron_left_rounded, size: 28, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Staff List",
                      style: AppTextStyles.heading(color: AppColors.textPrimary).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildHeaderActions(),
                ],
              ),
            ),

            // Scrollable Content area
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isWide = constraints.maxWidth > 900;
                  final bool isMedium = constraints.maxWidth > 600;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Search Bar
                            const CustomSearch(
                              hintText: 'Search by staff name or role...',
                            ),
                            const SizedBox(height: 24),

                            // User Collection
                            _buildUserList(isWide, isMedium),

                            const SizedBox(height: 32),

                            // Add Button - Responsive sizing
                            Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 400),
                                child: CustomButton(
                                  text: "ADD NEW USER",
                                  icon: Icons.add,
                                  iconLeading: true,
                                  backgroundColor: AppColors.primary,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onPressed: _showAddUserDialog,
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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

  Widget _buildHeaderActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.qr_code_scanner_rounded, size: 24, color: AppColors.textPrimary),
          onPressed: () {},
          tooltip: 'Scan staff ID',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.filter_list_rounded, size: 24, color: AppColors.textPrimary),
          onPressed: () {},
          tooltip: 'Filter staff',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildUserList(bool isWide, bool isMedium) {
    if (_users.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          children: [
            Icon(Icons.people_outline_rounded, size: 64, color: AppColors.textSecondary.withOpacity(0.3)),
            const SizedBox(height: 16),
            Text("No staff members found", style: AppTextStyles.body(color: AppColors.textSecondary)),
          ],
        ),
      );
    }

    if (isMedium || isWide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isWide ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 8,
          childAspectRatio: isWide ? 2.8 : 2.5,
        ),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return _buildUserCard(index);
        },
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _users.length,
      itemBuilder: (context, index) {
        return _buildUserCard(index);
      },
    );
  }

  Widget _buildUserCard(int index) {
    final user = _users[index];
    return UserManagementCard(
      key: ValueKey(user["email"] ?? index.toString()),
      name: user["name"] ?? "",
      role: user["role"] ?? "",
      phone: user["phone"],
      email: user["email"],
      onUpdate: (newName, newRole, newPhone, newEmail) => 
          _updateUser(index, newName, newRole, newPhone, newEmail),
      onDelete: () => _deleteUser(index),
    );
  }
}
