import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  String? text;
  PdfPreviewPage(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/images/deal1.png');
    final Uint8List byteList = bytes.buffer.asUint8List();

    // Get current date and time
    final DateTime now = DateTime.now();
    final String formattedDate = '${now.day}-${now.month}-${now.year}';
    final String formattedTime = '${now.hour}:${now.minute}';

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Header(text: "Your Invoice", level: 1),
                  pw.Image(
                    pw.MemoryImage(byteList),
                    fit: pw.BoxFit.fitHeight,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Paragraph(
                text: 'Product Details: $text',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Paragraph(
                text: 'Price: \$10.00',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Paragraph(
                text: 'Date: $formattedDate',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Paragraph(
                text: 'Time: $formattedTime',
                style: pw.TextStyle(fontSize: 14),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
