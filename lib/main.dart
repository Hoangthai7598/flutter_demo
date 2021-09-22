import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/bloc/comment_bloc.dart';
import 'package:testing/screens/home_screen.dart';

import 'bloc/comment_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Infinite List',
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => CommentBloc()..add(CommentFetchedEvent()),
          child: HomeScreen(),
        ));
  }
}
