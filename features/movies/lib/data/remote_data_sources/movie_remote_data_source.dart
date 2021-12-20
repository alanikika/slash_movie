import 'package:dio/dio.dart';
import 'package:movies/data/models/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponse> getMovies({required int page});
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<MovieResponse> getMovies({required int page}) async {
    try {
      final response = await dio.get(
        "https://yts.mx/api/v2/list_movies.json",
        queryParameters: {
          "page": page,
          "limit": 10,
          "sort_by": "title",
          "order_by": "desc"
        },
      );
      return MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }
}
