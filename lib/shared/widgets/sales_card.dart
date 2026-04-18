import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A premium sales card component designed for product listings.
/// 
/// It features a top section with a product image and an add button,
/// and a bottom section with category, title, and price.
class SalesCard extends StatelessWidget {
  /// The image source (could be asset path or network URL).
  final String imageUrl;

  /// The category label displayed at the top of the info section.
  final String category;

  /// The main title of the product.
  final String title;

  /// The formatted price string.
  final String price;

  /// Callback function when the plus icon is tapped.
  final VoidCallback? onAddTap;

  /// Callback function when the card itself is tapped.
  final VoidCallback? onTap;

  /// Whether the image is a network image or an asset.
  final bool isNetworkImage;

  const SalesCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.price,
    this.onAddTap,
    this.onTap,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: Image and Add Button
            Stack(
              children: [
                // Background tinted area
                Container(
                  height: 180,
                  width: double.infinity,
                  color: const Color(0xFFE8EFFF), // Very light blue background to match image
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4), // Slightly rounded corners for the product image
                      child: isNetworkImage
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => 
                                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                            )
                          : Image.asset(
                              imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => 
                                  const Icon(Icons.shopping_bag_outlined, size: 50, color: Colors.grey),
                            ),
                    ),
                  ),
                ),
                // Add Button (Constant Plus Icon)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onAddTap,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add_circle_outline_rounded,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Bottom Section: Info
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.toUpperCase(),
                    style: AppTextStyles.body().copyWith(
                      color: const Color(0xFF8E8E93), // Specific grey from image
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: AppTextStyles.subHeading().copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: 19,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    price,
                    style: AppTextStyles.heading().copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
