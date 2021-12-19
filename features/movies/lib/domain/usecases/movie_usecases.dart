import 'package:movies/domain/entities/movie_entity.dart';
import 'package:movies/domain/repositories/movie_repositories.dart';

abstract class MovieUseCases {
  Future<List<Movies>> getMovies();
}

class MovieUseCasesImpl extends MovieUseCases {

  final MovieRepositories movieRepositories;

  MovieUseCasesImpl({required this.movieRepositories});

  @override
  Future<List<Movies>> getMovies() async {
    return await movieRepositories.getMovies();
  }
}