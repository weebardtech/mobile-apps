// part of 'user_list_bloc_bloc.dart';

// abstract class UserListBlocEvent extends Equatable {
//   const UserListBlocEvent();
// }

// class GetUserList extends UserListBlocEvent {
//   final String apiToken;

//   const GetUserList({required this.apiToken});

//   @override
//   List<Object> get props => [apiToken];

//   @override
//   String toString() => 'OnCallRoomList { token: $apiToken}';

//   // static map(DropdownMenuItem<RoomData> Function(RoomData room) param0) {}
// }

part of 'user_list_bloc_bloc.dart';

abstract class UserListBlocEvent extends Equatable {
  const UserListBlocEvent();
}

class GetUserList extends UserListBlocEvent {
  final String token;
  final String keyword;

  const GetUserList({required this.token, required this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() => 'OnCallUserList { token: $token}';

  static map(
      DropdownMenuItem<EmployeeData> Function(EmployeeData user) param0) {}
}
