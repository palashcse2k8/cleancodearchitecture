
import 'package:flutter/material.dart';

class SingleChildScrolView extends StatelessWidget {
  const SingleChildScrolView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: Column(
                  children: [
                for (int i = 0; i < 20; i++)
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: double.infinity,
                    color: Colors.blue,
                  )
              ])
            );
        },
      ),
    );
  }
}