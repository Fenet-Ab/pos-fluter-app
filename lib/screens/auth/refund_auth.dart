import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/keyboard.dart';
import '../../models/order_model.dart';
import '../../services/transaction_service.dart';
import '../../core/routes/app_routes.dart';

class RefundAuthScreen extends StatefulWidget {
  final Order order;

  const RefundAuthScreen({super.key, required this.order});

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
      appBar: CustomTopBar(
        title: 'AUTHORIZE REFUND',
        showStatus: false,
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () => Navigator.pop(context),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '|',
              style: TextStyle(
                color: Colors.grey.withOpacity(0.4),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _pin = "";
                });
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'CLEAR',
                style: TextStyle(
                  color: Color(0xFFE94E2A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.5,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    children: [
                      TotalCard(
                        title: 'TOTAL',
                        value:
                            'ETB ${widget.order.totalAmount.toStringAsFixed(2)}',
                        height: 90,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Manager PIN Required",
                        style: AppTextStyles.heading(
                          color: AppColors.textPrimary,
                        ).copyWith(fontSize: 22, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Enter 6-digit code to authorize the return of\nfunds.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(
                          color: AppColors.textSecondary,
                        ).copyWith(fontSize: 14, fontWeight: FontWeight.w500),
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
                              color: isFilled
                                  ? AppColors.primary
                                  : Colors.transparent,
                              border: isFilled
                                  ? null
                                  : Border.all(
                                      color: AppColors.border,
                                      width: 1.5,
                                    ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 48),
                      CustomKeyboard(onKeyTap: _onKeyTap),
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
                  if (_pin.length == _pinLength) {
                    if (_pin == "123456") {
                      // Update transaction status
                      TransactionService().refundOrder(widget.order.id);
                      
                      Navigator.pushNamed(
                        context,
                        AppRoutes.refundSuccess,
                        arguments: {'order': widget.order},
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.refundError,
                        arguments: {'order': widget.order},
                      );
                   }
                  }
                },
                backgroundColor: const Color(
                  0xFF2DCC70,
                ), // Slightly brighter green to match the image
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
