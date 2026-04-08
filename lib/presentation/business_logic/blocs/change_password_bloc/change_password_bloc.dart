import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weebird_app/data/repositories/user_list_repository.dart';

import 'change_password_state.dart';
part 'change_password_event.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserListRepository repository;

  // final AuthBloc authBloc;

  ChangePasswordBloc(this.repository) : super(ChangePassInitial()) {
    on<ChangePasswordButtonPressed>((event, emit) async {
      try {
        emit(ChangePassLoading());
        if (event.currentPassword.isEmpty || event.newPassword.isEmpty) {
          emit(ChangePassEmptyData());
        } else {
          final data = await repository.GetUserList(
              event.apiToken, event.currentPassword);
          if (data.statusCode == 200) {
            emit(ChangePasswordSuccess());
          } else if (data.statusCode == 401) {
            emit(UnAuthorized());
          } else {
            emit(ChangePasswordFailure(error: data.message));
          }

          // authBloc.add(LoggedIn(token: token));
        }
      } catch (e) {
        emit(ChangePasswordFailure(error: e.toString()));
      }
    });
  }
}
