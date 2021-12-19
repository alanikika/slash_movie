import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/bloc.dart';
import 'package:shared/shared.dart';
import 'package:slash_movie/bloc/bloc_observer.dart';
import 'package:slash_movie/ui/splash_screen.dart';
import 'package:slash_movie/ui/welcome_screen.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((_) => Dio()),
        Bind.singleton((i) => CoreModule(baseUrl: "https://yts.mx/api/v2/")),
        Bind.singleton((i) => SharedModule()),
        Bind.singleton((i) => Routes()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, __) => const SplashScreen(),
        ),
        ChildRoute(
          Modular.get<Routes>().welcome,
          child: (_, __) => const WelcomeScreen(),
        ),
        ModuleRoute(
          Modular.get<Routes>().authModule,
          module: AuthModule(),
          transition: TransitionType.rightToLeftWithFade,
        ),
        ModuleRoute(
          Modular.get<Routes>().movieModule,
          module: MovieModule(),
        ),
      ];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Modular.get<MoviesBloc>(),
        ),
      ],
      child: const MaterialApp(
        title: "Turbo Movie",
        debugShowCheckedModeBanner: true,
        home: Scaffold(
          backgroundColor: Colors.white,
        ),
      ).modular(),
    );
  }
}
