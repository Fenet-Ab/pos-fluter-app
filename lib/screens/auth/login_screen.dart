import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../models/user_model.dart';
import '../../core/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _pin = "";
  final int _pinLength = 6;

  void _attemptLogin() {
    if (_pin.length < _pinLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a 6-digit PIN'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 20,
            right: 20,
          ),
        ),
      );
      return;
    }

    try {
      final user = User.dummyUsers.firstWhere((u) => u.pin == _pin);
      // Login successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome, ${user.name}!'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 20,
            right: 20,
          ),
        ),
      );
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.dashboard,
        arguments: {'user': user},
      );
    } catch (e) {
      // Login failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid PIN. Please try again.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 20,
            right: 20,
          ),
        ),
      );
      setState(() {
        _pin = "";
      });
    }
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // User Icon
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F0FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // PIN Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_pinLength, (index) {
                          bool isFilled = index < _pin.length;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isFilled ? AppColors.success : const Color(0xFFD9DCE0),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 30),
                      // Forgot PIN
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "FORGOT PIN?",
                          style: AppTextStyles.body(color: AppColors.primary).copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Numeric Keypad
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            _buildKeypadRow(['1', '2', '3']),
                            const SizedBox(height: 40),
                            _buildKeypadRow(['4', '5', '6']),
                            const SizedBox(height: 40),
                            _buildKeypadRow(['7', '8', '9']),
                            const SizedBox(height: 40),
                            _buildKeypadRow(['CLEAR', '0', 'BACKSPACE']),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomButton(
                          text: "Login",
                          onPressed: _attemptLogin,
                          mainAxisAlignment: MainAxisAlignment.center,
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Footer
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                "SYSTEM ONLINE",
                                style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "SYSTEM READY • V2.4.0 BUILD 882",
                            style: AppTextStyles.body(color: const Color(0xFFA0A3BD)).copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: keys.map((key) => _buildKeypadButton(key)).toList(),
    );
  }

  Widget _buildKeypadButton(String key) {
    if (key == 'BACKSPACE') {
      return InkWell(
        onTap: () => _onKeyTap(key),
        child: const SizedBox(
          width: 60,
          child: Icon(
            Icons.backspace_outlined,
            color: Color(0xFF434654),
            size: 28,
          ),
        ),
      );
    }

    if (key == 'CLEAR') {
      return InkWell(
        onTap: () => _onKeyTap(key),
        child: SizedBox(
          width: 60,
          child: Text(
            "CLEAR",
            style: AppTextStyles.body(color: const Color(0xFF434654)).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: () => _onKeyTap(key),
      child: SizedBox(
        width: 60,
        child: Center(
          child: Text(
            key,
            style: AppTextStyles.heading(color: AppColors.textPrimary).copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
