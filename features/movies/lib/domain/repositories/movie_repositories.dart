import 'package:movies/domain/entities/movie_entity.dart';

abstract class MovieRepositories {
  Future<MovieEntity> getMovies({required int page});
}