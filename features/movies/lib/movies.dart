library movies;

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies/data/remote_data_sources/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repositories_impl.dart';
import 'package:movies/domain/repositories/movie_repositories.dart';
import 'package:movies/domain/usecases/movie_usecases.dart';
import 'package:movies/presentation/bloc/bloc.dart';
import 'package:movies/presentation/movies_screen.dart';
import 'package:shared/shared.dart';

class MovieModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.get<Routes>().listMoviesPage,
          child: (context, args) => const MoviesScreen(),
        )
      ];

  @override
  List<Bind> get binds => [
        Bind((_) => MovieUseCasesImpl(
            movieRepositories: Modular.get<MovieRepositories>())),
        Bind((_) => MovieRepositoriesImpl(
            movieRemoteDataSource: Modular.get<MovieRemoteDataSource>())),
        Bind((_) => MovieRemoteDataSourceImpl(dio: Modular.get<Dio>())),
        Bind((_) => MoviesBloc(movieUseCases: Modular.get<MovieUseCases>())),
      ];
}
