import 'package:movies/data/remote_data_sources/movie_remote_data_source.dart';
import 'package:movies/domain/entities/movie_entity.dart';
import 'package:movies/domain/repositories/movie_repositories.dart';

class MovieRepositoriesImpl extends MovieRepositories {
  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoriesImpl({required this.movieRemoteDataSource});

  @override
  Future<MovieEntity> getMovies({required int page}) async {
    final movies = await movieRemoteDataSource.getMovies(page: page);
    List<Movies> newMovies = [];
    if (movies.data?.movies != null) {
      movies.data?.movies?.forEach((data) {
        var movie = Movies(
          mediumCoverImage: data.mediumCoverImage,
          title: data.title,
          rating: data.rating,
          genres: data.genres,
        );
        newMovies.add(movie);
      });
    }
    Data data = Data(
      pageNumber: movies.data!.pageNumber!,
      movies: newMovies,
    );

    MovieEntity movieEntity = MovieEntity(
      status: movies.status!,
      statusMessage: movies.statusMessage!,
      data: data,
    );
    return movieEntity;
  }
}
