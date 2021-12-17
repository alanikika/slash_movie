library auth;

import 'package:auth/presentation/auth_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/common/routes.dart';

class AuthModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.get<Routes>().authPage,
          child: (context, args) => const AuthScreen(),
        )
      ];
}
