import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponse> getMovies();
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<MovieResponse> getMovies() async {
    try {
      final response = await dio.get(
        "https://yts.mx/api/v2/list_movies.json",
        queryParameters: {
          "limit": 10,
          "sort_by": "title",
          "order_by": "ASC"
        },
      );
      return MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }
}
