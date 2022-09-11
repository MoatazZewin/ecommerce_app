import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/modules/login/cubit/login_states.dart';
import 'package:ecommerce_app/shared/network/remote/dio/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  late LoginModel loginModel;
  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.Post(path: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSucessState(loginModel));
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data);
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginErorrState(onError.toString()));
    });
  }

  bool isScure = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isScure = !isScure;
    suffix =
        isScure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityState());
  }
}
