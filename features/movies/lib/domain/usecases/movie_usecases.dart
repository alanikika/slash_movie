import 'package:movies/domain/entities/movie_entity.dart';
import 'package:movies/domain/repositories/movie_repositories.dart';

abstract class MovieUseCases {
  Future<MovieEntity> getMovies({required int page});
}

class MovieUseCasesImpl extends MovieUseCases {

  final MovieRepositories movieRepositories;

  MovieUseCasesImpl({required this.movieRepositories});

  @override
  Future<MovieEntity> getMovies({required int page}) async {
    return await movieRepositories.getMovies(page: page);
  }
}