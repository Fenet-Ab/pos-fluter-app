import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'user_form_dialog.dart';

/// A reusable user management card component matching the SAVVY POS design.
///
/// This card displays user details including an avatar, name, and role chip,
/// along with action buttons for editing and more options.
class UserManagementCard extends StatelessWidget {
  /// The full name of the user.
  final String name;

  /// The role of the user (e.g., Manager, Cashier).
  final String role;

  /// The phone number (not visible on card, but used in form).
  final String? phone;

  /// The email address (not visible on card, but used in form).
  final String? email;

  /// Callback when a user is updated.
  final Function(String name, String role, String phone, String email)? onUpdate;

  /// Callback when a user is deleted.
  final VoidCallback? onDelete;

  const UserManagementCard({
    super.key,
    required this.name,
    required this.role,
    this.phone,
    this.email,
    this.onUpdate,
    this.onDelete,
  });

  void _showEditDialog(BuildContext context) {
    UserFormDialog.show(
      context,
      title: "Edit User",
      initialName: name,
      initialRole: role,
      initialPhone: phone,
      initialEmail: email,
      onSave: (newName, newRole, newPhone, newEmail) {
        if (onUpdate != null) {
          onUpdate!(newName, newRole, newPhone, newEmail);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the first letter of the name for the avatar
    final String initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0), // Lighter border
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFFE9F0FF), // Soft light blue
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: const TextStyle(
                color: Color(0xFF1A60D1), // Specific blue for initial
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // User Info (Name & Role Chip)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF434654), // Dark grey from image
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                _RoleChip(role: role),
              ],
            ),
          ),

          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _showEditDialog(context),
                icon: const Icon(Icons.edit_outlined),
                color: const Color(0xFFAAB2C8), // Light grey icons
                iconSize: 22,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete' && onDelete != null) {
                    onDelete!();
                  }
                },
                icon: const Icon(Icons.more_vert_rounded),
                color: Colors.white,
                elevation: 4,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconColor: const Color(0xFFAAB2C8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: AppColors.error)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final String role;

  const _RoleChip({required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F0FF), // Same light blue as avatar
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF1A60D1), // Same blue as initial
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
