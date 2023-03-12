
import 'package:flutter/material.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              "This is test App"),
          titleTextStyle: Theme.of(context).textTheme.displayMedium,
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Please enter some text',
                border: OutlineInputBorder(), hintText: 'Search...'
              ),
              onChanged: (text){},
            ),
            Expanded(
                child: _buildResult(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResult() {
    return const Center(
      child: Text('No Result..'),
    );
  }
}


