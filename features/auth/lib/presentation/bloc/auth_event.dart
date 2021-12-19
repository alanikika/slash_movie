import 'package:equatable/equatable.dart';

const String tag = "AUTH EVENT";

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostLogin extends AuthEvent {
  final String username;
  final String password;

  PostLogin({required this.username, required this.password});

  @override
  String toString() => "$tag => PostLogin, username: $username, password: $password}";
}
