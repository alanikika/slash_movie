import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/shared.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        left: false,
        right: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Image.asset(ImagePath.appIcon),
              const SizedBox(height: 32.0),
              TextInput(
                controller: usernameController,
                label: "User name",
              ),
              const SizedBox(height: 16.0),
              TextInput(
                controller: passwordController,
                label: "Password",
              ),
              const SizedBox(height: 32.0),
              CustomButton(
                onTap: () {
                  Modular.to.pushNamed(Modular.get<Routes>().movieModule);
                },
                label: 'Login',
              )
            ],
          ),
        ),
      ),
    );
  }
}
