import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/user_list_response.dart';
import '../../../../../data/repositories/user_list_repository.dart';

part 'user_list_bloc_event.dart';
part 'user_list_bloc_state.dart';

class UserListBlocBloc extends Bloc<UserListBlocEvent, UserListBlocState> {
  final UserListRepository repository;

  UserListBlocBloc(this.repository) : super(Initial()) {
    on<GetUserList>((event, emit) async {
      try {
        emit(Loading());
        if (event.token.isEmpty) {
          emit(Failure(error: "Token is missing"));
        } else {
          final response =
              await repository.GetUserList(event.token, event.keyword);

          if (response.statusCode == 200) {
            final data = response.data;
            if (data.isEmpty) {
              emit(EmptyData());
            } else {
              emit(Success(data));
            }
          } else {
            emit(Failure(error: "something error!"));
          }
        }
      } catch (e) {
        // print(e);
        emit(Failure(error: e.toString()));
      }
    });
  }
}
