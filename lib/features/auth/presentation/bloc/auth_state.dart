part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class ProfessionLoading extends AuthState {}

class ProfessionLoaded extends AuthState {
  final List<ProfessionModel> professions;
  ProfessionLoaded(this.professions);
}

class ProfessionError extends AuthState {
  final String message;
  ProfessionError(this.message);
}

class Authorized extends AuthState {}

class Unauthorized extends AuthState {}
