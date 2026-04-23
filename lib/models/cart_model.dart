import 'product_model.dart';

class Cart {
  final Product product;
  final int quantity;

  Cart({required this.product, this.quantity = 1});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'quantity': quantity};
  }

  double get totalPrice => product.price * quantity;
}
