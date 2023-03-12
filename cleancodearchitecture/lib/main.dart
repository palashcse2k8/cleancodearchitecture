import 'package:cleancodearchitecture/bloc/blocapp.dart';
import 'package:flutter/material.dart';

import 'basics/singlechildscrolview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LearningPage(),
    );
  }
}

class LearningPage extends StatefulWidget {
  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  String title = "My Home page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container (
          color: Colors.green,
          width: 500,
          height: 300,
          margin: EdgeInsets.only(left: 20, top: 20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    "http://picsum.photos/200",
                    height: 200,
                    width: 200,
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint('single tapped');
                    },
                    onDoubleTap: () {
                      debugPrint ('on double tap');
                    },
                    onLongPress: (){
                      debugPrint ('on long tap');
                    },

                    child: RotatedBox(
                      quarterTurns: 0,
                      child: Text (
                        title,
                        // textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed:
                  () {
                    debugPrint("You clicked me!");
                    title = DateTime.now().toString();

                    setState(() {

                    });

                  }, child: Text(
                    "Buton"
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value) {
                      title = value;
                      debugPrint(value);
                      setState(() {

                      });
                    },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
