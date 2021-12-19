import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_entity.dart';

const String tagState = "MOVIES STATE";

abstract class MoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {
  @override
  String toString() => "$tagState MoviesInitial";
}

class MoviesLoading extends MoviesState {
  @override
  String toString() => "$tagState MoviesLoading";
}

class MoviesHasData extends MoviesState {
  final List<Movies> data;

  MoviesHasData({required this.data});
  
  @override
  String toString() => "$tagState MoviesHasData";
}

class MoviesNoData extends MoviesState {
  final String message;

  MoviesNoData({required this.message});
  
  @override
  String toString() => "$tagState MovieNoData";
}

class MoviesNoInternetConnection extends MoviesState {
  final String message;

  MoviesNoInternetConnection({required this.message});

  @override
  String toString() => "$tagState => message: $message";
}

class MoviesError extends MoviesState {

  final String message;

  MoviesError({required this.message});

  @override
  String toString() => "$tagState MoviesError => message: $message";
}