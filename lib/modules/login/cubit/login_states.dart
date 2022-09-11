import 'package:ecommerce_app/models/login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSucessState extends LoginStates{
  LoginModel loginModel;
  LoginSucessState(this.loginModel);
}
class LoginErorrState extends LoginStates{
  final String erorr;
  LoginErorrState(this.erorr);
}

class LoginPasswordVisibilityState extends LoginStates{}