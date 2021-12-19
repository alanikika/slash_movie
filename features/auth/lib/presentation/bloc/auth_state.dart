import 'package:equatable/equatable.dart';

const String tag = "AUTH STATE:";

abstract class AuthState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  String toString() => "$tag AuthLoading";
}

class AuthSuccess extends AuthState {
  @override
  String toString() => "$tag AuthSuccess";
}

class AuthError extends AuthState {

  final String message;

  AuthError({required this.message});

  @override
  String toString() => "$tag AuthError => message: $message";
}