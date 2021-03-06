import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/bloc/comment/comment_bloc.dart';
import 'package:testing/bloc/comment/comment_event.dart';
import 'package:testing/bloc/comment/comment_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfiniteList();
}

class _InfiniteList extends State<HomeScreen> {
  late CommentBloc _commentBloc;
  //scroll controller
  final _scrollController = ScrollController();
  final _scrollThreadhold = 0.5;

  @override
  void initState() {
    super.initState();
    _commentBloc = BlocProvider.of(context);
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        //scroll to the end of 1 page
        _commentBloc.add(CommentFetchedEvent());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentStateInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CommentStateFailure) {
            return const Center(
              child: Text(
                'Cannot load comments from Server',
                style: TextStyle(fontSize: 22, color: Colors.red),
              ),
            );
          }
          if (state is CommentStateSuccess) {
            if (state.comments.isEmpty) {
              return Center(child: Text('Empty comments !'));
            }
            return ListView.builder(
                itemBuilder: (BuildContext buildContext, int index) {
                  if (index >= state.comments.length) {
                    return Container(
                      alignment: Alignment.center,
                      child: const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      leading: Text('${state.comments[index].id}'),
                      title: Text('${state.comments[index].email}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      isThreeLine: true,
                      subtitle: Text('${state.comments[index].body}',
                          style: const TextStyle(fontSize: 18)),
                    );
                  }
                },
                itemCount: state.hasReachedEnd
                    ? state.comments.length
                    : state.comments.length + 1, //add more item
                controller: _scrollController);
          }
          return const Center(
              child: Text(
                  'Other states..')); //never run this line, only fix warning.
        },
      )),
    );
  }
}
