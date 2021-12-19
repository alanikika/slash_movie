import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              TextField(
                decoration: InputDecoration(
                  hintText: "User name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                minLines: 1,
              ),
              const SizedBox(height: 32.0),
              CustomButton(
                onTap: () {},
                label: 'Login',
              )
            ],
          ),
        ),
      ),
    );
  }
}
