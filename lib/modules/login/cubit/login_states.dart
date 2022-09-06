abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSucessState extends LoginStates{}
class LoginErorrState extends LoginStates{
  final String erorr;
  LoginErorrState(this.erorr);
}

class LoginPasswordVisibilityState extends LoginStates{}