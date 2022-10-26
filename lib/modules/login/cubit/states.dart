//import 'package:e_commerce/models/login/login_model.dart';
import 'package:shop_store/models/login/login_model.dart';

abstract class LoginState{}
class LoadingLogin extends LoginState{}
class LoginInitState extends LoginState{}
class LoginSuccessState extends LoginState{
  final LoginModel model;
  LoginSuccessState(this.model);
}
class LoginFailedState extends LoginState
{
  final String error;
  LoginFailedState(this.error);
}
class ChangePasswordVisState extends LoginState{}


