import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/keyboard.dart';

class RefundAuthScreen extends StatefulWidget {
  const RefundAuthScreen({super.key});

  @override
  State<RefundAuthScreen> createState() => _RefundAuthScreenState();
}

class _RefundAuthScreenState extends State<RefundAuthScreen> {
  String _pin = "";
  final int _pinLength = 6;

  void _onKeyTap(String key) {
    if (key == 'CLEAR') {
      setState(() {
        _pin = "";
      });
    } else if (key == 'BACKSPACE') {
      if (_pin.isNotEmpty) {
        setState(() {
          _pin = _pin.substring(0, _pin.length - 1);
        });
      }
    } else {
      if (_pin.length < _pinLength) {
        setState(() {
          _pin += key;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "AUTHORIZE REFUND",
              style: AppTextStyles.subHeading(color: AppColors.primary).copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 1,
              height: 20,
              color: AppColors.border,
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () {
                setState(() {
                  _pin = "";
                });
              },
              child: Text(
                "CLEAR",
                style: AppTextStyles.subHeading(color: AppColors.error).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: Column(
                    children: [
                      const TotalCard(
                        title: 'TOTAL',
                        value: 'ETB 417.45',
                        height: 90,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Manager PIN Required",
                        style: AppTextStyles.heading(color: AppColors.textPrimary).copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Enter 6-digit code to authorize the return of\nfunds.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_pinLength, (index) {
                          bool isFilled = index < _pin.length;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isFilled ? AppColors.primary : Colors.transparent,
                              border: isFilled ? null : Border.all(
                                color: AppColors.border,
                                width: 1.5,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 48),
                      CustomKeyboard(
                        onKeyTap: _onKeyTap,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: AppColors.secondary,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: CustomButton(
                text: "AUTHORIZE & PAYOUT",
                onPressed: () {
                  // Perform authorize action
                },
                backgroundColor: const Color(0xFF2DCC70), // Slightly brighter green to match the image
                textColor: Colors.white,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
