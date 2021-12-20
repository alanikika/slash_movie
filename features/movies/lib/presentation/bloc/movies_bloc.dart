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
    final currentState = state;

    if (event is LoadMovies) {
      try {
        MovieEntity _movieEntity = MovieEntity();
        if (event.isInitial) {
          yield MoviesLoading();
          _movieEntity = await movieUseCases.getMovies(page: 1);
        } else if (currentState is MoviesHasData &&
            !_movieHasReachedMax(currentState)) {
          _movieEntity =
              await movieUseCases.getMovies(page: currentState.currentPage + 1);
        }

        if (_movieEntity.data?.movies.length != null) {
          if (event.isInitial) {
            yield MoviesHasData(
              hasReachedMax:
                  _movieEntity.data!.movies.isNotEmpty ? false : true,
              currentPage: _movieEntity.data?.pageNumber as int,
              data: _movieEntity.data?.movies as List<Movies>,
            );
          } else {
            MoviesHasData hasData = state as MoviesHasData;
            yield MoviesHasData(
              hasReachedMax:
                  _movieEntity.data!.movies.isNotEmpty ? false : true,
              currentPage: _movieEntity.data?.pageNumber as int,
              data: hasData.data + (_movieEntity.data?.movies as List<Movies>),
            );
          }
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

  bool _movieHasReachedMax(MoviesState state) =>
      state is MoviesHasData && state.hasReachedMax;
}
