import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A reusable user management card component matching the SAVVY POS design.
///
/// This card displays user details including an avatar, name, and role chip,
/// along with action buttons for editing and more options.
class UserManagementCard extends StatelessWidget {
  /// The full name of the user.
  final String name;

  /// The role of the user (e.g., Manager, Cashier).
  final String role;

  /// Callback when the edit button is tapped.
  final VoidCallback? onEdit;

  /// Callback when the more options button is tapped.
  final VoidCallback? onMore;

  /// The icon to display for more options (defaults to more_vert).
  final IconData moreIcon;

  const UserManagementCard({
    super.key,
    required this.name,
    required this.role,
    this.onEdit,
    this.onMore,
    this.moreIcon = Icons.more_vert_rounded,
  });

  @override
  Widget build(BuildContext context) {
    // Get the first letter of the name for the avatar
    final String initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFE9EEFF), // Light blue background
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: AppTextStyles.subHeading(
                color: AppColors.primary,
              ).copyWith(
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
                  style: AppTextStyles.body(
                    color: AppColors.textPrimary,
                  ).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                _RoleChip(role: role),
              ],
            ),
          ),

          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
                color: const Color(0xFFAAB2C8),
                iconSize: 24,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: onMore,
                icon: Icon(moreIcon),
                color: const Color(0xFFAAB2C8),
                iconSize: 24,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEFF), // Light blue background for chip
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role,
        style: AppTextStyles.body(
          color: AppColors.primary,
        ).copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
