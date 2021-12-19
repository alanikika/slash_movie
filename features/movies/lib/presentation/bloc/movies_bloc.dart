import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_entity.dart';
import 'package:movies/domain/usecases/movie_usecases.dart';
import 'package:movies/presentation/bloc/bloc.dart';

class MoviesBloc extends Bloc<MovieEvent, MoviesState> {
  final MovieUseCases movieUseCases;

  MoviesBloc({required this.movieUseCases}) : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(MovieEvent event) async* {
    if (event is LoadMovies) {
      try {
        yield MoviesLoading();

        List<Movies> _movieEntity = await movieUseCases.getMovies();

        if (_movieEntity.isNotEmpty) {
          yield MoviesHasData(data: _movieEntity);
        } else {
          yield MoviesNoData(message: "No Movie Available");
        }
      } on IOException {
        yield MoviesNoInternetConnection(message: "You are offline");
      } on TimeoutException {
        yield MoviesNoInternetConnection(message: "Request Time Out");
      } catch (e) {
        debugPrint("error: $e");
        yield MoviesError(message: e.toString());
      }
    }
  }
}
