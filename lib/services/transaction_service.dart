import '../models/order_model.dart';
import '../models/cart_model.dart';

class TransactionService {
  static final TransactionService _instance = TransactionService._internal();
  factory TransactionService() => _instance;
  TransactionService._internal();

  final List<Order> _orders = [
    Order(
      id: '#SAV-94827-EP',
      items: [],
      totalAmount: 417.45,
      orderDate: DateTime.now().subtract(const Duration(minutes: 45)),
      paymentMethod: 'Telebirr',
      status: 'Completed',
    ),
    Order(
      id: '#SAV-94828-RE',
      items: [],
      totalAmount: 110.00,
      orderDate: DateTime.now().subtract(const Duration(hours: 1)),
      paymentMethod: 'Cash',
      status: 'Refunded',
    ),
    Order(
      id: '#SAV-94829-FA',
      items: [],
      totalAmount: 845.00,
      orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      paymentMethod: 'Bank Card',
      status: 'Failed',
    ),
    Order(
      id: '#SAV-94826-EP',
      items: [],
      totalAmount: 2490.50,
      orderDate: DateTime.now().subtract(const Duration(hours: 3, minutes: 20)),
      paymentMethod: 'Cash',
      status: 'Completed',
    ),
  ];

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders.add(order);
  }

  void saveTransaction({
    required String orderId,
    required double totalAmount,
    required String paymentMethod,
    required DateTime orderDate,
    required List<CartItem> items,
  }) {
    final order = Order(
      id: orderId,
      items: items,
      totalAmount: totalAmount,
      orderDate: orderDate,
      paymentMethod: paymentMethod,
      status: 'Completed',
    );
    _orders.add(order);
  }

  void refundOrder(String orderId) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final oldOrder = _orders[index];
      _orders[index] = Order(
        id: oldOrder.id,
        items: oldOrder.items,
        totalAmount: oldOrder.totalAmount,
        orderDate: oldOrder.orderDate,
        paymentMethod: oldOrder.paymentMethod,
        status: 'Refunded',
      );
    }
  }

  List<Order> getRecentTransactions() {
    // Return last 24 hours or just all for now sorted by date
    return _orders.reversed.toList();
  }
}
