import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MovieFetchedEvent extends MovieEvent {}
