part of 'user_list_bloc_bloc.dart';

abstract class UserListBlocState extends Equatable {}

class Initial extends UserListBlocState {
  @override
  List<Object> get props => [];
}

class Loading extends UserListBlocState {
  @override
  List<Object> get props => [];
}

class Success extends UserListBlocState {
  final List<EmployeeData> users;

  Success(this.users);

  @override
  List<Object?> get props => [users];
}

class EmptyData extends UserListBlocState {
  @override
  List<Object> get props => [];
}

class NetworkError extends UserListBlocState {
  @override
  List<Object> get props => [];
}

class Failure extends UserListBlocState {
  final String error;

  Failure({required this.error});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Employee { error: $error }';
}
