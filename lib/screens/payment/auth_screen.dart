import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/footer.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              "AUTHORIZE TRANSACTION",
              style: AppTextStyles.subHeading(color: AppColors.primary).copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 13,
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
                // Clear action
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      // Signature Box
                      CustomPaint(
                        painter: _DashedBorderPainter(color: AppColors.border.withOpacity(0.8)),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Please sign inside the box below",
                                style: AppTextStyles.body(color: AppColors.textSecondary).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    // Underline
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 1,
                                        margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                                        color: AppColors.border.withOpacity(0.5),
                                      ),
                                    ),
                                    // "X" Marker
                                    Positioned(
                                      bottom: 24,
                                      left: 16,
                                      child: Text(
                                        "X",
                                        style: AppTextStyles.heading(color: AppColors.border).copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    // Simulated Signature rendering
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 24, left: 32, right: 32),
                                        child: SizedBox(
                                          width: 200,
                                          height: 80,
                                          child: CustomPaint(
                                            painter: _SignaturePainter(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Clear & Redo Button
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.refresh_rounded, color: AppColors.primary, size: 16),
                        label: Text(
                          "Clear & Redo",
                          style: AppTextStyles.body(color: AppColors.primary).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Transaction Details Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6FC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Merchant Info
                            Row(
                              children: [
                                _buildIconBlock(Icons.storefront_outlined),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "MERCHANT",
                                        style: AppTextStyles.body(color: const Color(0xFF8A94A6)).copyWith(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Savvy IT - Addis Ababa Store",
                                        style: AppTextStyles.body(color: AppColors.textPrimary).copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Date/Time and Transaction ID
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildIconBlock(Icons.calendar_today_outlined),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "DATE/TIME",
                                              style: AppTextStyles.body(color: const Color(0xFF8A94A6)).copyWith(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 1.0,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "March 27,\n2026 •\n11:45 AM",
                                              style: AppTextStyles.body(color: AppColors.textPrimary).copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w900,
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildIconBlock(Icons.point_of_sale_outlined), // Receipt or point of sale icon
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "TRANSACTION ID",
                                              style: AppTextStyles.body(color: const Color(0xFF8A94A6)).copyWith(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 1.0,
                                              ),
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "#SAV-\n94827-EP",
                                              style: AppTextStyles.body(color: AppColors.textPrimary).copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w900,
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                text: "COMPLETE & PRINT RECEIPT",
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

  Widget _buildIconBlock(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: AppColors.primary,
        size: 16,
      ),
    );
  }
}

/// Draws an aesthetic dashed border around a container boundary
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    // Top
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
    // Bottom
    startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height), Offset(startX + dashWidth, size.height), paint);
      startX += dashWidth + dashSpace;
    }
    // Left
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
    // Right
    startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width, startY), Offset(size.width, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Simulates the user signature using a bezier curve path
class _SignaturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.1, size.width * 0.35, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.8, size.width * 0.6, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.1, size.width, size.height * 0.8);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
