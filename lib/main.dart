import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/bloc/comment/comment_bloc.dart';
import 'package:testing/screens/home_screen.dart';
import 'package:testing/screens/movie_screen.dart';
import 'package:testing/screens/setting_screen.dart';

import 'bloc/comment/comment_event.dart';
import 'bloc/movie/movie_bloc.dart';
import 'bloc/movie/movie_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Movie App';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xB8262626)),
        debugShowCheckedModeBanner: false,
        home: MyStatefulWidget());
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List _children = [
    BlocProvider(
      create: (context) => MovieBloc()..add(MovieFetchedEvent()),
      child: const MovieScreen(),
    ),
    BlocProvider(
      create: (context) => CommentBloc()..add(CommentFetchedEvent()),
      child: const HomeScreen(),
    ),
    BlocProvider(
      create: (context) => CommentBloc()..add(CommentFetchedEvent()),
      child: const SettingScreen(),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF3d3d3c),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
