import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit.dart';
import '../../logic/cubitcounter.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter using bloc'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CubitCounter, CounterState>(
              listener: (context, state) {
                if(state.incremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Incremented!"),
                    duration: Duration(milliseconds: 100),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Decremented!"),
                    duration: Duration(milliseconds: 100),
                  ));
                }
              },
              builder: (context, state) {
                return Text(
                  state.initialCounter.toString(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () =>
                      BlocProvider.of<CubitCounter>(context).increment(),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () =>
                      BlocProvider.of<CubitCounter>(context).decrement(),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}