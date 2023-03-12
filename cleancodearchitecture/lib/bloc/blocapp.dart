import 'package:bloc/bloc.dart';
import 'package:cleancodearchitecture/bloc/presentation/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit.dart';
import 'logic/cubitcounter.dart';

class BlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<CubitCounter>(
      create: (context) => CubitCounter(),
      child: MaterialApp(
        title: "Counter using bloc",
        home: HomeScreen(),
      ),
    );
  }
}

