import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(" Input All Your Data Here"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: () {})
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              controller: nameController,
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              controller: phoneNumberController,
              decoration: new InputDecoration(
                hintText: "Phone",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              controller: emailController,
              decoration: new InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          new ListTile(
            leading: const Icon(Icons.today),
            title: const Text('Birthday'),
            subtitle: const Text('February 18, 1990'),
          ),
          ElevatedButton(
            onPressed: processPDF,
            child: Text("Preview"),
          )
        ],
      ),
    );
  }

  Future<void> processPDF() async {

    Data data = new Data(name: nameController.toString(), phoneNumber: phoneNumberController.toString(), email: emailController.toString());

    // Navigator.push(
    //   context,
    //   // MaterialPageRoute(builder: (context) => null),
    // );
  }
}



Future<Uint8List> generateDocument(Data data) async {
  final pw.Document doc = pw.Document();

  doc.addPage(pw.MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (pw.Context context) {
        if (context.pageNumber == 1) {
          return pw.Container();
        }
        return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            // decoration: pw.BoxDecoration(
            //     border: pw.BoxBorder(
            //         bottom: true, width: 0.5, color: PdfColors.grey)
            // ),
            child: pw.Text('Portable Document Format',
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (pw.Context context) => <pw.Widget>[
            pw.Table.fromTextArray(
                context: context,
                border: null,
                headerAlignment: pw.Alignment.centerLeft,
                data: <List<String>>[
                  <String>['Name', 'Phone Number', 'Email'],
                  <String>[data.name, data.phoneNumber, data.email]
                ]),
            pw.Paragraph(text: ""),
            // pw.Paragraph(text: "Subtotal: $total"),
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
          ]));

  return doc.save();
}

class Data {
  String name;
  String phoneNumber;
  String email;

  Data({required this.name, required this.phoneNumber, required this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    return data;
  }
}
