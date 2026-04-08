import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

class ChangePassInitial extends ChangePasswordState {}

class ChangePassLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class UnAuthorized extends ChangePasswordState {}

class ChangePassEmptyData extends ChangePasswordState {}

class NetworkError extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final String error;

  ChangePasswordFailure({required this.error});

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ChangePasswordFailure { error: $error }';
}
