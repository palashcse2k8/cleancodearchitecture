import 'package:cleancodearchitecture/pdf_generator/pdfpreviewpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class DetailPage extends StatelessWidget {
  final Invoice invoice;

  const DetailPage({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(invoice: invoice,),
            ),
          );
          // rootBundle.
        },
        child: Icon(Icons.picture_as_pdf),
      ),
      appBar: AppBar(
        title: Text(invoice.customer),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Customer',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      invoice.customer,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: [
                  Text(
                    'Invoice Items',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ...invoice.items.map(
                    (e) => ListTile(
                      title: Text(e.description),
                      trailing: Text(
                        e.cost.toStringAsFixed(2),
                      ),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.headlineSmall,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Total"),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            invoice.totalCost().toStringAsFixed(2),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
