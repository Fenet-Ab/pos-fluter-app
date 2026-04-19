import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Configuration for a single item in the sidebar.
class SidebarItem {
  final IconData icon;
  final String title;
  final String? id;
  final VoidCallback? onTap;

  const SidebarItem({
    required this.icon,
    required this.title,
    this.id,
    this.onTap,
  });
}

/// A highly customizable and reusable Sidebar component for POS applications.
class Sidebar extends StatelessWidget {
  final String title;
  final String status;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isSubPage;
  final bool showLeadingIcon;
  final bool showTrailingIcon;
  final bool showStatus;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? leading;
  final Widget? trailing;
  final List<SidebarItem> items;
  final String? selectedId;
  final Function(SidebarItem)? onItemSelected;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailingTap;

  const Sidebar({
    super.key,
    this.title = 'SAVVY POS',
    this.status = 'ONLINE',
    this.leadingIcon,
    this.trailingIcon,
    this.isSubPage = false,
    this.showLeadingIcon = true,
    this.showTrailingIcon = true,
    this.showStatus = true,
    this.backgroundColor,
    this.borderColor,
    this.leading,
    this.trailing,
    required this.items,
    this.selectedId,
    this.onItemSelected,
    this.onLeadingTap,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor ?? Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SidebarHeader(
              title: title,
              status: status,
              leadingIcon: leadingIcon,
              trailingIcon: trailingIcon,
              isSubPage: isSubPage,
              showLeadingIcon: showLeadingIcon,
              showTrailingIcon: showTrailingIcon,
              showStatus: showStatus,
              backgroundColor: backgroundColor,
              borderColor: borderColor,
              leading: leading,
              trailing: trailing,
              onLeadingTap: onLeadingTap,
              onTrailingTap: onTrailingTap,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isActive = selectedId != null && item.id == selectedId;

                  return _SidebarListTile(
                    item: item,
                    isActive: isActive,
                    onTap: () {
                      if (item.onTap != null) item.onTap!();
                      if (onItemSelected != null) onItemSelected!(item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarListTile extends StatelessWidget {
  final SidebarItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarListTile({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive
            ? AppColors.primary.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          item.icon,
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          size: 22,
        ),
        title: Text(
          item.title,
          style:
              AppTextStyles.body(
                color: isActive ? AppColors.primary : AppColors.textPrimary,
              ).copyWith(
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                fontSize: 15,
              ),
        ),
        trailing: isActive
            ? Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            : null,
      ),
    );
  }
}

class SidebarHeader extends StatelessWidget {
  final String title;
  final String status;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isSubPage;
  final bool showLeadingIcon;
  final bool showTrailingIcon;
  final bool showStatus;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailingTap;

  const SidebarHeader({
    super.key,
    this.title = 'SAVVY POS',
    this.status = 'ONLINE',
    this.leadingIcon,
    this.trailingIcon,
    this.isSubPage = false,
    this.showLeadingIcon = true,
    this.showTrailingIcon = true,
    this.showStatus = true,
    this.backgroundColor,
    this.borderColor,
    this.leading,
    this.trailing,
    this.onLeadingTap,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveLeadingIcon = isSubPage
        ? (leadingIcon ?? Icons.arrow_back_ios_new_rounded)
        : (leadingIcon ?? Icons.menu);

    final effectiveTrailingIcon = trailingIcon ?? Icons.person;

    return Container(
      constraints: const BoxConstraints(minHeight: 90),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border(
          bottom: BorderSide(
            color: borderColor ?? AppColors.border.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading section
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 16),
          ] else if (showLeadingIcon) ...[
            InkWell(
              onTap:
                  onLeadingTap ??
                  (isSubPage ? () => Navigator.of(context).pop() : null),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  effectiveLeadingIcon,
                  color: AppColors.textPrimary,
                  size: isSubPage ? 22 : 28,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.subHeading(color: AppColors.primary)
                      .copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        letterSpacing: -0.5,
                      ),
                ),
                if (showStatus) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: AppTextStyles.body(
                          color: AppColors.success,
                        ).copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Trailing section
          if (trailing != null)
            trailing!
          else if (showTrailingIcon)
            InkWell(
              onTap: onTrailingTap,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  effectiveTrailingIcon,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
