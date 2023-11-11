import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'connection_state.dart';

class ConnectionCubit extends Cubit<CheckConnectionState> {
  ConnectionCubit() : super(ConnectionInitial());

  void init() async {
    emit(ConnectionLoading());

    var con = await Connectivity().checkConnectivity();

    connection(con);

    Connectivity().onConnectivityChanged.listen((event) {
      connection(event);
    });
  }

  void connection(ConnectivityResult con) {
    if (con == ConnectivityResult.none) {
      emit(ConnectionFailure());
    } else {
      emit(ConnectionSuccess());
    }
  }

  @override
  void emit(CheckConnectionState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
