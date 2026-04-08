part of 'user_logout_bloc.dart';

abstract class UserLogoutEvent extends Equatable {
  const UserLogoutEvent();
}

class UserLogoutButtonPressed extends UserLogoutEvent {
  final String token;

  const UserLogoutButtonPressed({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'UserLogoutButtonPressed { email: $token}';
}
