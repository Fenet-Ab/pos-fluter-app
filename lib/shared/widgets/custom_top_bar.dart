import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A premium, highly customizable Top Bar for the SAVVY POS application.
///
/// This widget implements [PreferredSizeWidget] so it can be used directly
/// in the [appBar] property of a [Scaffold].
class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title text, typically the app name or page title.
  final String title;

  /// The status text, e.g., 'ONLINE' or 'OFFLINE'.
  final String status;

  /// Custom widget for the leading section. If provided, [leadingIcon] is ignored.
  final Widget? leading;

  /// Custom widget for the trailing section. If provided, [trailingIcon] is ignored.
  final Widget? trailing;

  /// The icon to show on the left side (default: [Icons.menu]).
  final IconData? leadingIcon;

  /// The icon to show on the right side (default: [Icons.person_rounded]).
  final IconData? trailingIcon;

  /// Whether to show the leading icon/widget.
  final bool showLeadingIcon;

  /// Whether to show the trailing icon/widget.
  final bool showTrailingIcon;

  /// Whether to show the status indicator.
  final bool showStatus;

  /// Callback when the leading icon is tapped.
  /// Defaults to opening the Scaffold drawer if it's a menu icon.
  final VoidCallback? onLeadingTap;

  /// Callback when the trailing icon is tapped.
  final VoidCallback? onTrailingTap;

  /// Background color of the top bar.
  final Color? backgroundColor;

  /// Border color for the bottom divider.
  final Color? borderColor;

  /// Height of the top bar.
  final double height;

  const CustomTopBar({
    super.key,
    this.title = 'SAVVY POS',
    this.status = 'ONLINE',
    this.leading,
    this.trailing,
    this.leadingIcon,
    this.trailingIcon,
    this.showLeadingIcon = true,
    this.showTrailingIcon = true,
    this.showStatus = true,
    this.onLeadingTap,
    this.onTrailingTap,
    this.backgroundColor,
    this.borderColor,
    this.height = 75,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + MediaQuery.of(context).padding.top,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: borderColor ?? AppColors.border.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading Section
            if (leading != null)
              leading!
            else if (showLeadingIcon)
              _buildIconButton(
                icon: leadingIcon ?? Icons.menu,
                onTap: onLeadingTap ?? () => Scaffold.of(context).openDrawer(),
              ),

            const SizedBox(width: 4),

            // Logo/Title & Status
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.subHeading(color: AppColors.primary)
                        .copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: -0.8,
                        ),
                  ),
                  if (showStatus) ...[
                    const SizedBox(width: 16),
                    _StatusIndicator(status: status),
                  ],
                ],
              ),
            ),

            // Trailing Section
            if (trailing != null)
              trailing!
            else if (showTrailingIcon)
              _buildProfileIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: AppColors.textPrimary.withOpacity(0.7),
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileIcon() {
    return InkWell(
      onTap: onTrailingTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(
          trailingIcon ?? Icons.person_rounded,
          color: AppColors.primary,
          size: 32,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _StatusIndicator extends StatelessWidget {
  final String status;

  const _StatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
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
          const SizedBox(width: 8),
          Text(
            status,
            style: AppTextStyles.body(color: AppColors.success).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
