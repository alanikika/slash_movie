import 'package:equatable/equatable.dart';

const String tagEvent = "MOVIES EVENT:";

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMovies extends MovieEvent {
  final bool isInitial;

  LoadMovies({this.isInitial = false});

  @override
  String toString() => "$tagEvent LoadMovies => isInitial: $isInitial";
}