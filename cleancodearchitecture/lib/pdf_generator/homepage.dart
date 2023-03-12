import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'formpage.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar (
          centerTitle: true,
          title: Text (
            "PDF Generator",
          ),
        ),
        body: Center(
          child: Container(
            child: ElevatedButton (
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormPage()),
                );
              },
              child: Text (
                  "Click to Add Data"
              ),
            ),
          ),
        ),
      );
  }
}

