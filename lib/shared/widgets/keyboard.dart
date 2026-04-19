import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final double? height;
  final double? width;

  const CustomKeyboard({
    super.key,
    required this.onKeyTap,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> keys = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'CLEAR',
      '0',
      'BACKSPACE',
    ];

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F0FF), // Premium light blue background
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final key = keys[index];
          return KeyboardButton(
            label: key,
            onTap: () => onKeyTap(key),
          );
        },
      ),
    );
  }
}

class KeyboardButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const KeyboardButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isClear = label == 'CLEAR';

    return Container(
      decoration: BoxDecoration(
        color: isClear ? const Color(0xFFF1EEF9) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isClear
            ? Border.all(color: AppColors.error.withOpacity(0.15), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: (isClear ? AppColors.error : AppColors.primary).withOpacity(0.1),
          highlightColor: (isClear ? AppColors.error : AppColors.primary).withOpacity(0.05),
          child: Center(
            child: _buildChild(),
          ),
        ),
      ),
    );
  }

  Widget _buildChild() {
    if (label == 'BACKSPACE') {
      return const Icon(
        Icons.backspace_outlined,
        color: AppColors.textPrimary,
        size: 32,
      );
    }

    if (label == 'CLEAR') {
      return Text(
        'CLEAR',
        style: AppTextStyles.subHeading(color: AppColors.error).copyWith(
          fontWeight: FontWeight.w900,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      );
    }

    return Text(
      label,
      style: AppTextStyles.heading(color: AppColors.textPrimary).copyWith(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
