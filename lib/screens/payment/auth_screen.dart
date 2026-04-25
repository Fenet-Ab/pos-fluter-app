import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../success/success_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/footer.dart';
import 'package:intl/intl.dart';
import '../../core/utils/receipt_helper.dart';
import '../../services/transaction_service.dart';
import '../../models/cart_model.dart';

class AuthScreen extends StatefulWidget {
  final String? orderId;
  final DateTime? orderDate;
  final double totalAmount;
  final String paymentMethod;
  final List<CartItem> cartItems;

  const AuthScreen({
    super.key,
    this.orderId,
    this.orderDate,
    this.totalAmount = 0.0,
    this.paymentMethod = "Cash",
    this.cartItems = const [],
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _selectedIndex = 0;
  late SignatureController _controller;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black87,
      exportBackgroundColor: Colors.transparent,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              style: AppTextStyles.subHeading(
                color: AppColors.primary,
              ).copyWith(fontWeight: FontWeight.w900, fontSize: 13),
            ),
            const SizedBox(width: 10),
            Container(width: 1, height: 16, color: AppColors.border),
            const SizedBox(width: 2),
            TextButton(
              onPressed: () {
                _controller.clear();
              },
              child: Text(
                "CLEAR",
                style: AppTextStyles.subHeading(
                  color: AppColors.error,
                ).copyWith(fontWeight: FontWeight.w900, fontSize: 13),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      // Signature Box
                      CustomPaint(
                        painter: _DashedBorderPainter(
                          color: AppColors.border.withOpacity(0.8),
                        ),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Please sign inside the box below",
                                style:
                                    AppTextStyles.body(
                                      color: AppColors.textSecondary,
                                    ).copyWith(
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
                                        margin: const EdgeInsets.only(
                                          bottom: 24,
                                          left: 16,
                                          right: 16,
                                        ),
                                        color: AppColors.border.withOpacity(
                                          0.5,
                                        ),
                                      ),
                                    ),
                                    // "X" Marker
                                    Positioned(
                                      bottom: 24,
                                      left: 16,
                                      child: Text(
                                        "X",
                                        style:
                                            AppTextStyles.heading(
                                              color: AppColors.border,
                                            ).copyWith(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                    ),
                                    // Simulated Signature rendering
                                    // Interactive Signature Pad
                                    Positioned.fill(
                                      child: Signature(
                                        controller: _controller,
                                        backgroundColor: Colors.transparent,
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
                        onPressed: () {
                          _controller.clear();
                        },
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        label: Text(
                          "Clear & Redo",
                          style: AppTextStyles.body(
                            color: AppColors.primary,
                          ).copyWith(fontWeight: FontWeight.bold, fontSize: 13),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "MERCHANT",
                                        style:
                                            AppTextStyles.body(
                                              color: const Color(0xFF8A94A6),
                                            ).copyWith(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1.0,
                                            ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Savvy IT - Addis Ababa Store",
                                        style:
                                            AppTextStyles.body(
                                              color: AppColors.textPrimary,
                                            ).copyWith(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildIconBlock(
                                        Icons.calendar_today_outlined,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "DATE/TIME",
                                              style:
                                                  AppTextStyles.body(
                                                    color: const Color(
                                                      0xFF8A94A6,
                                                    ),
                                                  ).copyWith(
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 1.0,
                                                  ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "${DateFormat('MMMM dd, yyyy').format(widget.orderDate ?? DateTime.now())}\n•\n${DateFormat('hh:mm a').format(widget.orderDate ?? DateTime.now())}",
                                              style:
                                                  AppTextStyles.body(
                                                    color:
                                                        AppColors.textPrimary,
                                                  ).copyWith(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildIconBlock(
                                        Icons.point_of_sale_outlined,
                                      ), // Receipt or point of sale icon
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "TRANSACTION ID",
                                              style:
                                                  AppTextStyles.body(
                                                    color: const Color(
                                                      0xFF8A94A6,
                                                    ),
                                                  ).copyWith(
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 1.0,
                                                  ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              (widget.orderId ??
                                                      "#SAV-ONLINE-EP")
                                                  .replaceAll('-', '-\n'),
                                              style:
                                                  AppTextStyles.body(
                                                    color:
                                                        AppColors.textPrimary,
                                                  ).copyWith(
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
                backgroundColor: const Color(
                  0xFF1B8B41,
                ), // Rich green matching the design
                textColor: Colors.white,
                mainAxisAlignment: MainAxisAlignment.center,
                isLoading: _isProcessing,
                onPressed: () {
                  if (_isProcessing) return;
                  _handleCompleteAndPrint();
                },
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

  Future<void> _handleCompleteAndPrint() async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please provide a signature before completing."),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 120,
            left: 20,
            right: 20,
          ),
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final signatureImage = await _controller.toPngBytes();

      final orderId =
          widget.orderId ??
          "#SAV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}-EP";
      final orderDate = widget.orderDate ?? DateTime.now();

      // Generate and Download PDF
      await ReceiptHelper.generateAndDownloadReceipt(
        orderId: orderId,
        orderDate: orderDate,
        totalAmount: widget.totalAmount,
        signatureImage: signatureImage,
      );

      // Save the transaction to the service
      TransactionService().saveTransaction(
        orderId: orderId,
        totalAmount: widget.totalAmount,
        paymentMethod: widget.paymentMethod,
        orderDate: orderDate,
        items: widget.cartItems,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            signatureImage: signatureImage,
            orderId: orderId,
            orderDate: orderDate,
            totalAmount: widget.totalAmount,
            paymentMethod: widget.paymentMethod,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error generating receipt: $e"),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Widget _buildIconBlock(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: AppColors.primary, size: 16),
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
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX + dashWidth, size.height),
        paint,
      );
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
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
