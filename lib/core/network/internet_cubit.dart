import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

enum ConnectionType { Wifi, Mobile }

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription<List<ConnectivityResult>>
  connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (results.contains(ConnectivityResult.wifi)) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (results.contains(ConnectivityResult.mobile)) {
        emitInternetConnected(ConnectionType.Mobile);
      } else {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType type) =>
      emit(InternetConnected(connectionType: type));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
