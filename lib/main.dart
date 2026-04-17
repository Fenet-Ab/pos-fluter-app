import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'shared/widgets/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POS Application',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('App Theme Applied!'),
              const SizedBox(height: 20),
              CustomButton(
                icon: Icons.arrow_forward,
                text: "Secondary Action",
                backgroundColor: Colors.transparent,
                textColor: AppColors.primary,
                borderColor: AppColors.primary,
                borderWidth: 2,
                mainAxisAlignment: MainAxisAlignment.center,
                iconLeading: true,
                // icon: Icons.arrow_forward,
                onPressed: () {
                  // Action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
