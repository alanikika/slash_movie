import 'package:movies/domain/entities/movie_entity.dart';

abstract class MovieRepositories {
  Future<List<Movies>> getMovies();
}