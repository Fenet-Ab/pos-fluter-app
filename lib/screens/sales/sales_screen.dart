import 'package:flutter/material.dart';
import '../../shared/widgets/custom_top_bar.dart';
import '../../shared/widgets/custom_search.dart';
import '../../shared/widgets/sales_card.dart';
import '../../shared/widgets/footer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/product_model.dart';
import '../cart/cart_sale.dart';
import '../../models/cart_model.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  int _selectedCategoryIndex = 0;
  final List<CartItem> _cartItems = [];

  int get _cartItemCount {
    int count = 0;
    for (var item in _cartItems) {
      count += item.quantity;
    }
    return count;
  }
  final List<String> _categories = [
    'All Items',
    'Beverages',
    'Bakery',
    'Spices',
    'Spies',
    'Spice',
  ];

  // Dummy product data
  List<Product> get _inventoryList => Product.dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTopBar(
        title: 'SAVVY POS',
        centerTitle: true,
        showStatus: false,
        leadingIcon: Icons.arrow_back,
        trailingIcon: Icons.shopping_cart,
        trailingBadgeCount: _cartItemCount,
        onLeadingTap: () {
          Navigator.pop(context);
        },
        onTrailingTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartSaleScreen(cartItems: _cartItems)),
          );
          setState(() {});
        },
      ),
      body: Column(
        children: [
          // Categories
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _categories[index],
                      style: AppTextStyles.body().copyWith(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF5A667B),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Search
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomSearch(hintText: 'Search products, SKUs...'),
          ),

          const SizedBox(height: 16),

          // Product Grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 2;
                if (constraints.maxWidth >= 900) {
                  crossAxisCount = 5;
                } else if (constraints.maxWidth >= 600) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth >= 450) {
                  crossAxisCount = 3;
                }

                // Calculate dynamic aspect ratio to prevent overflow
                double totalPadding = 32.0; // left 16, right 16
                double totalSpacing = (crossAxisCount - 1) * 16.0;
                double itemWidth =
                    (constraints.maxWidth - totalPadding - totalSpacing) /
                    crossAxisCount;

                // Height includes: Top padding (10) + image height (itemWidth - 20) + bottom section fixed text heights (~145)
                double itemHeight = (itemWidth - 10) + 145;

                return GridView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 20,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: itemWidth / itemHeight,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _inventoryList.length,
                  itemBuilder: (context, index) {
                    final product = _inventoryList[index];
                    return SalesCard(
                      imageUrl: product.imageUrl,
                      category: product.category,
                      title: product.name,
                      price: 'ETB ${product.price.toStringAsFixed(2)}',
                      onAddTap: () {
                        setState(() {
                          final existingItemIndex = _cartItems.indexWhere((item) => item.product.name == product.name);
                          if (existingItemIndex >= 0) {
                            _cartItems[existingItemIndex].quantity++;
                          } else {
                            _cartItems.add(CartItem(product: product));
                          }
                        });
                      },
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: 0,
        onItemSelected: (index) {
          // Handle navigation if needed
        },
      ),
    );
  }
}
