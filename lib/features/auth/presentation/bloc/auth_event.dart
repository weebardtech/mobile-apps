part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final Map<String, dynamic> body;

  RegisterRequested(this.body);
}

class AppStarted extends AuthEvent {}

class LoadProfessions extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
