import 'dart:js';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class MyRandomApp extends StatelessWidget {
  MyRandomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: "Test App",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorite = <WordPair>[];

  void toggleFavorite() {
    if (favorite.contains(current)) {
      favorite.remove(current);
    } else {
      favorite.add(current);
    }
    notifyListeners();
  }

  void removeFavorite(int index) {
    for (var pair in favorite) {
      print (pair.toString());
    }
    favorite.removeAt(index);
    notifyListeners();
  }

}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritePage();
        break;
      default:
        throw UnimplementedError();
    }
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
                child: NavigationRail(
              extended: constraints.maxWidth >= 600,
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
                print('selected : ${value}');
              },
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
            )),
            Expanded(
                child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ))
          ],
        ),
      );
    });
  }
}

class FavoritePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var itemCount = appState.favorite.length;
    if(itemCount == 0) {
      return Center(
        child: Container(
            child: Text("No item yet...!")
        ),
      );
    } else {

      return Scaffold(
        appBar: AppBar (
          title:
          Text('You have '
              '${itemCount} favorites:'),
        ) ,
        body: ListView.builder(

          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Tooltip(
                message: 'Remove Item',
                child: IconButton(
                  icon: Icon(Icons.remove_circle_outlined),
                  onPressed: () {
                    appState.removeFavorite(index);
                  },
                ),
              ),
              trailing: Icon(Icons.remove),
              title: Text(
                appState.favorite.elementAt(index).toString(),
              ),
            );
          },

        ),
      );
    }
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    log('data: ${appState.current.asPascalCase}');

    IconData icon;
    if (appState.favorite.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("A random Idea."),
          BigCard(pair: pair),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  print("button pressed");
                  appState.getNext();
                },
                child: Text("Next"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium?.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}
