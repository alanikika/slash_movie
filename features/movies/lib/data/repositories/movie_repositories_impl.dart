import 'package:movies/data/remote_data_sources/movie_remote_data_source.dart';
import 'package:movies/domain/entities/movie_entity.dart';
import 'package:movies/domain/repositories/movie_repositories.dart';

class MovieRepositoriesImpl extends MovieRepositories {

  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoriesImpl({required this.movieRemoteDataSource});

  @override
  Future<List<Movies>> getMovies() async {
    List<Movies> movieEntity = [];
    final movies = await movieRemoteDataSource.getMovies();

    // movieEntity.status = movies.status;
    // movieEntity.statusMessage = movies.statusMessage;
    // movieEntity.data?.movieCount = movies.data?.movieCount;
    // movieEntity.data?.limit = movies.data?.limit;
    // movieEntity.data?.pageNumber = movies.data?.pageNumber;
    try {
      movies.data?.movies?.forEach((data) {
        print("---- ${data.title}");
        var movie = Movies(
          mediumCoverImage: data.mediumCoverImage,
          title: data.title,
          rating: data.rating,
          genres: data.genres,
        );
        movieEntity.add(movie);
      });
    } catch(e) {
      print("repo impl error: $e");
    }
    print(movieEntity.length.toString());
    return movieEntity;
  }

}