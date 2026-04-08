import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/repositories/user_logout_repository.dart';

part 'user_logout_event.dart';
part 'user_logout_state.dart';

class UserLogoutBloc extends Bloc<UserLogoutEvent, UserLogoutState> {
  final UserLogoutRepository logoutRepository;

  UserLogoutBloc(this.logoutRepository) : super(UserLogoutInitial()) {
    on<UserLogoutButtonPressed>((event, emit) async {
      try {
        emit(UserLogoutLoading());
        final data = await logoutRepository.postUserLogout(event.token);
        if (data.statusCode == 200) {
          emit(UserLogoutSuccess());
        } else {
          emit(UserLogoutFailure(error: data.message));
        }
      } catch (e) {
        emit(UserLogoutFailure(error: e.toString()));
      }
    });
  }
}
