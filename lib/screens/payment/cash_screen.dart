import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/keyboard.dart';
import '../../shared/widgets/footer.dart';

class CashScreen extends StatefulWidget {
  final double totalAmount;

  const CashScreen({super.key, required this.totalAmount});

  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {
  late String _amount;
  int _selectedIndex = 0; // Assuming home is active or matching others

  @override
  void initState() {
    super.initState();
    _amount = widget.totalAmount.toStringAsFixed(2);
  }

  void _onKeyTap(String key) {
    if (key == 'CLEAR') {
      setState(() {
        _amount = "0.00";
      });
    } else if (key == 'BACKSPACE') {
      if (_amount.isNotEmpty && _amount != "0" && _amount != "0.00") {
        setState(() {
          _amount = _amount.substring(0, _amount.length - 1);
          if (_amount.isEmpty) _amount = "0.00";
        });
      }
    } else {
      setState(() {
        if (_amount == "0" || _amount == "0.00") {
           _amount = key;
        } else {
           _amount += key;
        }
      });
    }
  }

  void _addAmount(int amountToAdd) {
    setState(() {
      double current = double.tryParse(_amount) ?? 0.0;
      _amount = (current + amountToAdd).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFF),
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
              "CASH PAYMENT",
              style: AppTextStyles.subHeading(color: AppColors.primary).copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 1,
              height: 16,
              color: AppColors.border,
            ),
            const SizedBox(width: 2),
            TextButton(
              onPressed: () {
                setState(() {
                  _amount = "0.00";
                });
              },
              child: Text(
                "CLEAR",
                style: AppTextStyles.subHeading(color: AppColors.error).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      // Total Card
                      TotalCard(
                        title: "AMOUNT RECEIVED",
                        value: "ETB $_amount",
                        height: 90,
                      ),
                      const SizedBox(height: 24),

                      // Quick Amount Buttons
                      Row(
                        children: [
                          _buildQuickAmount(50),
                          const SizedBox(width: 12),
                          _buildQuickAmount(100),
                          const SizedBox(width: 12),
                          _buildQuickAmount(200),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Number Pad
                      CustomKeyboard(
                        onKeyTap: _onKeyTap,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom Action Area
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: CustomButton(
                text: "COMPLETE",
                backgroundColor: const Color(0xFF1B8B41), // Rich green matching the design
                textColor: Colors.white,
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: () {},
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

  Widget _buildQuickAmount(int amount) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _addAmount(amount),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              "+$amount",
              style: AppTextStyles.heading(color: AppColors.primary).copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
