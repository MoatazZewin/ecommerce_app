import 'package:ecommerce_app/models/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterPasswordVisibilityState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  LoginModel? model;
  RegisterSuccessState(this.model);
}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {}