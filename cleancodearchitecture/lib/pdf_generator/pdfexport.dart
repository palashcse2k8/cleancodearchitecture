import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'model.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/sonali-bank-logo.png'))
          .buffer
          .asUint8List());

  final pdf = Document();
  pdf.addPage(
    Page(build: (Context context) {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Attention to: ${invoice.customer}"),
                Text(invoice.address),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.cover, image: MemoryImage(imageLogo.bytes)),
              ),
            ),
          ],
        ),
        Table(
          border: TableBorder.all(color: PdfColors.black),
          children: [
            // The first row just contains a phrase 'INVOICE FOR PAYMENT'
            TableRow(
              children: [
                Padding(
                  child: Text(
                    'INVOICE FOR PAYMENT',
                    style: Theme.of(context).header4,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ],
            ),
            // The remaining rows contain each item from the invoice, and uses the
            // map operator (the ...) to include these items in the list
            ...invoice.items.map(
              // Each new line item for the invoice should be rendered on a new TableRow
              (e) => TableRow(
                children: [
                  // We can use an Expanded widget, and use the flex parameter to specify
                  // how wide this particular widget should be. With a flex parameter of
                  // 2, the description widget will be 66% of the available width.
                  Expanded(
                    child: Text(e.description),
                    flex: 2,
                  ),
                  // Again, with a flex parameter of 1, the cost widget will be 33% of the
                  // available width.
                  Expanded(
                    child: Text("\$${e.cost}"),
                    flex: 1,
                  )
                ],
              ),
            ),
            // After the itemized breakdown of costs, show the tax amount for this invoice
            // In this case, it's just 10% of the invoice amount
            TableRow(
              children: [
                Text('TAX', textAlign: TextAlign.right),
                Text('\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
              ],
            ),
            // Show the total
            TableRow(
              children: [
                Text('TOTAL', textAlign: TextAlign.right),
                Text("\$${invoice.totalCost()}"),
              ],
            )
          ],
        ),
        Padding(
          child: Text(
            "THANK YOU FOR YOUR BUSINESS!",
            style: Theme.of(context).header2,
          ),
          padding: EdgeInsets.all(20),
        ),
      ]);
    }),
  );
  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  String appDocumentsPath = appDocumentsDirectory.path; // 2
  String path = '$appDocumentsPath'; // 3
  final file = File('$path/example.pdf');
  await file.writeAsBytes(await pdf.save());
  return file.readAsBytes();
}
