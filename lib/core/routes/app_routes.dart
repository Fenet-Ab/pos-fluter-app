import 'package:flutter/material.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/payment/cbe_screen.dart';
import '../../screens/payment/payment_screen.dart';
import '../../screens/payment/card_screen.dart';
import '../../screens/payment/telebirr_screen.dart';
import '../../screens/payment/cash_screen.dart';
import '../../screens/payment/auth_screen.dart';
import '../../screens/error/error_screen.dart';
import '../../screens/landing/home.dart';
import '../../screens/sales/sales_screen.dart';
import '../../screens/reports/reports_screen.dart';
import '../../screens/cart/cart_sale.dart';
import '../../screens/refund/refund_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/success/success_screen.dart';
import '../../screens/user_management/user_management_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/transaction/transaction_history_screen.dart';
import '../../models/cart_model.dart';
import '../../models/user_model.dart';
import '../../screens/auth/refund_auth.dart';
import '../../screens/refund/refund_success.dart';
import '../../screens/refund/error_refund_screen.dart';
import '../../models/order_model.dart';
import 'dart:typed_data';

class AppRoutes {
  static const String landing = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String sales = '/sales';
  static const String cart = '/cart';
  static const String payment = '/payment';
  static const String cash = '/cash';
  static const String telebirr = '/telebirr';
  static const String cbe = '/cbe';
  static const String card = '/card';
  static const String success = '/success';
  static const String reports = '/reports';
  static const String userManagement = '/user-management';
  static const String settings = '/settings';
  static const String transactionHistory = '/transaction-history';
  static const String refund = '/refund';
  static const String auth = '/auth';
  static const String refundAuth = '/refund-auth';
  static const String refundSuccess = '/refund-success';
  static const String refundError = '/refund-error';
  static const String error = '/error';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case dashboard:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        final user = args?['user'] as User?;
        return MaterialPageRoute(builder: (_) => DashboardScreen(user: user));
      case sales:
        return MaterialPageRoute(builder: (_) => const SalesScreen());
      case cart:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        final cartItems = args?['cartItems'] as List<CartItem>? ?? [];
        return MaterialPageRoute(
          builder: (_) => CartSaleScreen(cartItems: cartItems),
        );
      case payment:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            totalAmount: args['totalAmount'],
            cartItems: args['cartItems'] ?? [],
          ),
        );
      case cash:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CashScreen(
            totalAmount: args['totalAmount'],
            cartItems: args['cartItems'] ?? [],
          ),
        );
      case telebirr:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TelebirrScreen(
            totalAmount: args['totalAmount'],
            cartItems: args['cartItems'] ?? [],
          ),
        );
      case cbe:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CbeBirrScreen(
            totalAmount: args['totalAmount'],
            cartItems: args['cartItems'] ?? [],
          ),
        );
      case card:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CardScreen(
            totalAmount: args['totalAmount'],
            cartItems: args['cartItems'] ?? [],
          ),
        );
      case success:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SuccessScreen(
            signatureImage: args['signatureImage'] as Uint8List?,
            orderId: args['orderId'] ?? "#SAV-94827-EP",
            orderDate: args['orderDate'] as DateTime?,
            totalAmount: args['totalAmount'] ?? 417.45,
            paymentMethod: args['paymentMethod'] ?? "Bank Card",
          ),
        );
      case reports:
        return MaterialPageRoute(builder: (_) => const ReportsScreen());
      case userManagement:
        return MaterialPageRoute(builder: (_) => const UserManagementScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case transactionHistory:
        return MaterialPageRoute(builder: (_) => const TransactionHistoryScreen());
      case refund:
        return MaterialPageRoute(builder: (_) => const RefundScreen());
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case refundAuth:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => RefundAuthScreen(order: args['order'] as Order),
        );
      case refundSuccess:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => RefundSuccessScreen(order: args['order'] as Order),
        );
      case refundError:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ErrorRefundScreen(order: args['order'] as Order),
        );
      case error:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${routeSettings.name}')),
          ),
        );
    }
  }
}
