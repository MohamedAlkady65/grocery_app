import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/category_model.dart';
import 'package:grocery_app/data/services/categories_services.dart';
import 'package:grocery_app/helper/functions.dart';

import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  CategoriesServices categoriesServices = CategoriesServices();

  Future<void> getCategories(BuildContext context) async {
    emit(Categoriesloading());
    final response = await categoriesServices.getCategories();
    if (response.state == DataResponse.success) {
      emit(CategoriesSuccess(response.data));
    } else {
      if (context.mounted) {
        emit(CategoriesFailure(context));
      }
    }
  }

  Future<void> getCategoriesAtHome(BuildContext context) async {
    emit(CategoriesAtHomeloading());
    final response = await categoriesServices.getCategories();
    if (response.state == DataResponse.success) {
      emit(CategoriesAtHomeSuccess(response.data));
    } else {
      if (context.mounted) {
        emit(CategoriesAtHomeFailure(context));
      }
    }
  }

  @override
  void emit(CategoriesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
