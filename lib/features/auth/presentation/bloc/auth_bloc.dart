import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/profession_model.dart';
import '../../domain/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {

    on<LoadProfessions>((event, emit) async {
      emit(ProfessionLoading());
      try {
        final data = await repository.getProfessions();
        emit(ProfessionLoaded(data));
      } catch (e) {
        emit(ProfessionError("Failed to load professions"));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthSuccess());
    });

    on<AppStarted>((event, emit) async {
      final isLoggedIn = await repository.isLoggedIn();
      if (isLoggedIn) {
        emit(Authorized());
      } else {
        emit(Unauthorized());
      }
    });




    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      final ok = await repository.login(event.email, event.password);

      if (ok) {
        await repository.saveToken("xosId89skdjhshhs89KK");
        emit(Authorized());
      } else {
        emit(AuthFailure("Invalid email or password"));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await repository.logout();
      emit(Unauthorized());
    });



  }
}
