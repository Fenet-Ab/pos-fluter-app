import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class ReceiptHelper {
  static Future<void> generateAndDownloadReceipt({
    required String orderId,
    required DateTime orderDate,
    required double totalAmount,
    required Uint8List? signatureImage,
  }) async {
    final pdf = pw.Document();

    final formattedDate = DateFormat('MMMM dd, yyyy').format(orderDate);
    final formattedTime = DateFormat('hh:mm a').format(orderDate);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80, // Receipt format
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text('SAVVY POS', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24)),
                    pw.Text('Addis Ababa, Ethiopia', style: pw.TextStyle(fontSize: 10)),
                    pw.SizedBox(height: 10),
                    pw.Text('OFFICIAL RECEIPT', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
              pw.Divider(),
              pw.Text('Order ID: $orderId'),
              pw.Text('Date: $formattedDate'),
              pw.Text('Time: $formattedTime'),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('TOTAL AMOUNT', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('ETB ${totalAmount.toStringAsFixed(2)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text('Customer Signature:', style: pw.TextStyle(fontSize: 10)),
              if (signatureImage != null)
                pw.Container(
                  height: 60,
                  width: 150,
                  child: pw.Image(pw.MemoryImage(signatureImage)),
                ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text('Thank you for your business!', style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontSize: 8)),
              ),
            ],
          );
        },
      ),
    );

    // This will open the print/save dialog on Mobile and Web
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'receipt_$orderId.pdf',
    );
  }
}
