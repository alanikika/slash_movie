import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/common/routes.dart';
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
        Bind.lazySingleton((i) => Routes()),
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
      ];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Turbo Movie",
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: Colors.white,
      ),
    ).modular();
  }
}
