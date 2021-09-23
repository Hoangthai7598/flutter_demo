import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/bloc/comment/comment_state.dart';
import 'package:testing/bloc/movie/movie_bloc.dart';
import 'package:testing/bloc/movie/movie_state.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieStateInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieStateFailure) {
              return const Center(
                child: Text(
                  'Cannot load movie from Server',
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
              );
            }
            if (state is MovieStateSuccess) {
              if (state.movies.isEmpty) {
                return Center(child: Text('Empty comments !'));
              }
              return CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: state.movies.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Stack(fit: StackFit.expand, children: <Widget>[
                            Image.network(i.poster),
                            Text(
                              i.title,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ]));
                    },
                  );
                }).toList(),
              );
            }
            return Container(
                child: Text('Fail..')); //never run this line, only fix warning.
          },
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: const Color(0xB8262626),
      leading: Padding(
        padding: EdgeInsets.all(16.0),
        child: IconButton(
          icon: const Icon(Icons.settings_accessibility),
          onPressed: () {},
        ),
      ),
      title: const Text(
        'Pocket TV',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.all(16.0),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)))
      ],
    );
  }
}
