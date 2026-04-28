import 'package:flutter/material.dart';
import '../../shared/widgets/total_card.dart';
import '../../shared/widgets/cart_card.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/footer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/routes/app_routes.dart';

import '../../models/cart_model.dart';

class CartSaleScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartSaleScreen({super.key, required this.cartItems});

  @override
  State<CartSaleScreen> createState() => _CartSaleScreenState();
}

class _CartSaleScreenState extends State<CartSaleScreen> {
  double get _totalAmount {
    double total = 0;
    for (var item in widget.cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.dashboard,
                (route) => false,
              );
            }
          },
        ),
        centerTitle: true,
        title: Text(
          'MY CART',
          style: AppTextStyles.subHeading().copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 18,
                width: 1,
                color: Colors.grey.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.cartItems.clear();
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(right: 16, left: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Clear',
                  style: AppTextStyles.body().copyWith(
                    color: const Color(0xFFE94E2A), // Red/Orange color for Clear
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          // Total Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: TotalCard(
              title: 'TOTAL',
              value: 'ETB ${_totalAmount.toStringAsFixed(2)}',
            ),
          ),

          // Cart Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return CartCard(
                  title: item.product.name,
                  unitPrice: item.product.price,
                  quantity: item.quantity,
                  onIncrement: () {
                    setState(() {
                      item.quantity++;
                    });
                  },
                  onDecrement: () {
                    if (item.quantity > 1) {
                      setState(() {
                        item.quantity--;
                      });
                    }
                  },
                  onDelete: () {
                    setState(() {
                      widget.cartItems.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),

          // Payment Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: CustomButton(
              text: 'COMPLETE PAYMENT',
              mainAxisAlignment: MainAxisAlignment.center,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.payment,
                  arguments: {
                    'totalAmount': _totalAmount,
                    'cartItems': widget.cartItems,
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: 1, // Highlighting Receipt index based on typical flow, or 0
        onItemSelected: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
