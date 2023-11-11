import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/landing_item_model.dart';
import 'package:grocery_app/data/services/landing_services.dart';
import 'package:meta/meta.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(LandingInitial());
  LandingServices landingServices = LandingServices();
  List<LandingItemModel> landingList = [];
  void getLanding() async {
    emit(LandingLoading());
    final response = await landingServices.getLanding();
    if (response.state == DataResponse.success) {
      landingList = response.data;
      emit(LandingSuccess());
    } else {
      emit(LandingFailure());
    }
  }

  @override
  void emit(LandingState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
