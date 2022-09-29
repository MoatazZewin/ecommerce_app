import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/login_model.dart';
import 'package:ecommerce_app/modules/register/register_cubit/register_states.dart';
import 'package:ecommerce_app/shared/network/remote/dio/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isObscure = true;
  IconData icon = Icons.visibility;

  void changePasswordVisibility() {
    isObscure = !isObscure;
    icon = isObscure ? Icons.visibility : Icons.visibility_off;
    emit(RegisterPasswordVisibilityState());
  }
  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.Post(path: register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value){
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((onError){
      print('error inside register${onError.toString()}');
      emit(RegisterErrorState());
    });
  }
}
