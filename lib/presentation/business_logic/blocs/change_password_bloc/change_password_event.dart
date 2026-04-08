part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final String apiToken;
  final String currentPassword;
  final String newPassword;

  const ChangePasswordButtonPressed(
      {required this.apiToken,
      required this.currentPassword,
      required this.newPassword});

  @override
  List<Object> get props => [currentPassword, newPassword];

  @override
  String toString() =>
      'ChangePasswordButtonPressed { currentPassword: $currentPassword, newPassword: $newPassword}';
}
