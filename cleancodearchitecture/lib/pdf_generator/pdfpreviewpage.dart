import 'package:cleancodearchitecture/pdf_generator/model.dart';
import 'package:cleancodearchitecture/pdf_generator/pdfexport.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final Invoice invoice;

  PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
        centerTitle: true,
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
      ),
    );
  }
//
// Future<Uint8List> makePdf(Invoice invoice) async {
//   final imageLogo = MemoryImage(
//       (await rootBundle.load('assets/sonali-bank-logo.png'))
//           .buffer
//           .asUint8List());
//
//   final pdf = pw.Document();
//   pdf.addPage(
//     pw.Page(build: (pw.Context context) {
//       return pw.Column(children: [
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Column(
//               children: [
//                 pw.Text("Attention to: ${invoice.customer}"),
//                 pw.Text(invoice.address),
//               ],
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//             ),
//             pw.Container(
//               width: 150,
//               height: 150,
//               decoration: pw.BoxDecoration(
//                 image: new pw.DecorationImage(
//                     fit: pw.BoxFit.cover,
//                     image: pw.MemoryImage(imageLogo.bytes)),
//               ),
//             ),
//
//           ],
//         ),
//         pw.Table(
//           border: pw.TableBorder.all(color: PdfColors.black),
//           children: [
//             // The first row just contains a phrase 'INVOICE FOR PAYMENT'
//             pw.TableRow(
//               children: [
//                 pw.Padding(
//                   child: pw.Text(
//                     'INVOICE FOR PAYMENT',
//                     style: pw.Theme.of(context).header4,
//                     textAlign: pw.TextAlign.center,
//                   ),
//                   padding: pw.EdgeInsets.all(20),
//                 ),
//               ],
//             ),
//             // The remaining rows contain each item from the invoice, and uses the
//             // map operator (the ...) to include these items in the list
//             ...invoice.items.map(
//               // Each new line item for the invoice should be rendered on a new TableRow
//                   (e) => pw.TableRow(
//                 children: [
//                   // We can use an Expanded widget, and use the flex parameter to specify
//                   // how wide this particular widget should be. With a flex parameter of
//                   // 2, the description widget will be 66% of the available width.
//                   pw.Expanded(
//                     child: pw.Text(e.description),
//                     flex: 2,
//                   ),
//                   // Again, with a flex parameter of 1, the cost widget will be 33% of the
//                   // available width.
//                   pw.Expanded(
//                     child: pw.Text("\$${e.cost}"),
//                     flex: 1,
//                   )
//                 ],
//               ),
//             ),
//             // After the itemized breakdown of costs, show the tax amount for this invoice
//             // In this case, it's just 10% of the invoice amount
//             pw.TableRow(
//               children: [
//                 pw.Text('TAX', textAlign: pw.TextAlign.right),
//                 pw.Text(
//                     '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
//               ],
//             ),
//             // Show the total
//             pw.TableRow(
//               children: [
//                 pw.Text('TOTAL', textAlign: pw.TextAlign.right),
//                 pw.Text("\$${invoice.totalCost()}"),
//               ],
//             )
//           ],
//         ),
//         pw.Padding(
//           child: pw.Text(
//             "THANK YOU FOR YOUR BUSINESS!",
//             style: pw.Theme.of(context).header2,
//           ),
//           padding: pw.EdgeInsets.all(20),
//         ),
//       ]);
//     }),
//   );
//   Directory appDocumentsDirectory =
//   await getApplicationDocumentsDirectory(); // 1
//   String appDocumentsPath = appDocumentsDirectory.path; // 2
//   String path = '$appDocumentsPath'; // 3
//   final file = File('$path/example.pdf');
//   await file.writeAsBytes(await pdf.save());
//   return file.readAsBytes();
// }
}
