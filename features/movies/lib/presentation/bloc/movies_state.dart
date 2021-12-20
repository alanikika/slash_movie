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
  final int currentPage;
  final List<Movies> data;
  final bool hasReachedMax;

  MoviesHasData({
    required this.currentPage,
    required this.data,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [currentPage, data, hasReachedMax];

  @override
  String toString() => "$tagState MoviesHasData => Page $currentPage, isMax: $hasReachedMax";
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
