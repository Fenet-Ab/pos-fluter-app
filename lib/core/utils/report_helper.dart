import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class ReportHelper {
  static Future<void> generateAndDownloadReport({
    required String filterType,
    required DateTime selectedDate,
    required String netSales,
    required String totalRefunds,
    required String estProfit,
    required List<Map<String, dynamic>> paymentMethods,
    required List<Map<String, dynamic>> topProducts,
  }) async {
    final pdf = pw.Document();

    final formattedDate = DateFormat('MMMM dd, yyyy').format(selectedDate);
    final reportTitle = '${filterType.toUpperCase()} SALES REPORT';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('SAVVY POS',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 24,
                          color: PdfColors.blue900)),
                  pw.Text(reportTitle,
                      style: const pw.TextStyle(
                          fontSize: 14, color: PdfColors.grey700)),
                ],
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text('Report Date: $formattedDate',
                style: const pw.TextStyle(fontSize: 12)),
            pw.Text(
                'Exported on: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
            pw.SizedBox(height: 30),

            // FINANCIAL SUMMARY
            pw.Text('FINANCIAL SUMMARY',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
            pw.Divider(),
            pw.SizedBox(height: 10),
            _buildSummaryRow('NET SALES', netSales, isPrimary: true),
            _buildSummaryRow('TOTAL REFUNDS', totalRefunds,
                color: PdfColors.red900),
            _buildSummaryRow('ESTIMATED PROFIT', estProfit, isPrimary: true),
            pw.SizedBox(height: 30),

            // PAYMENT METHODS breakdown
            pw.Text('PAYMENT METHOD BREAKDOWN',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _buildTableCell('METHOD', isHeader: true),
                    _buildTableCell('AMOUNT', isHeader: true, alignRight: true),
                  ],
                ),
                ...paymentMethods.map((m) => pw.TableRow(
                      children: [
                        _buildTableCell(m['method'].toString()),
                        _buildTableCell(m['amount'].toString(),
                            alignRight: true),
                      ],
                    )),
              ],
            ),
            pw.SizedBox(height: 30),

            // TOP SELLING PRODUCTS
            pw.Text('TOP SELLING PRODUCTS',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _buildTableCell('PRODUCT NAME', isHeader: true),
                    _buildTableCell('SKU', isHeader: true),
                    _buildTableCell('QUANTITY',
                        isHeader: true, alignRight: true),
                  ],
                ),
                ...topProducts.map((p) => pw.TableRow(
                      children: [
                        _buildTableCell(p['name'].toString()),
                        _buildTableCell(p['sku'].toString()),
                        _buildTableCell(p['quantity'].toString(),
                            alignRight: true),
                      ],
                    )),
              ],
            ),

            pw.SizedBox(height: 40),
            pw.Center(
              child: pw.Text(
                  'This report was generated automatically by Savvy POS system.',
                  style: pw.TextStyle(
                      fontSize: 8,
                      fontStyle: pw.FontStyle.italic,
                      color: PdfColors.grey600)),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name:
          'report_${filterType.toLowerCase()}_${DateFormat('yyyyMMdd').format(selectedDate)}.pdf',
    );
  }

  static pw.Widget _buildTableCell(String text,
      {bool isHeader = false, bool alignRight = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        textAlign: alignRight ? pw.TextAlign.right : pw.TextAlign.left,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  static pw.Widget _buildSummaryRow(String label, String value,
      {bool isPrimary = false, PdfColor? color}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey800)),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: color ?? (isPrimary ? PdfColors.blue800 : PdfColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
