part of 'user_logout_bloc.dart';

abstract class UserLogoutState extends Equatable {
  const UserLogoutState();

  @override
  List<Object?> get props => [];
}

class UserLogoutInitial extends UserLogoutState {}

class UserLogoutLoading extends UserLogoutState {}

class UserLogoutSuccess extends UserLogoutState {}

class UserLogoutEmptyData extends UserLogoutState {}

class UserLogoutNetworkError extends UserLogoutState {}

class UserLogoutFailure extends UserLogoutState {
  final String error;

  UserLogoutFailure({required this.error});

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ResetPasswordFailure { error: $error }';
}
