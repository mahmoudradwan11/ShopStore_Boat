import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/models/login/login_model.dart';
import 'package:shop_store/modules/login/cubit/states.dart';
import 'package:shop_store/shared/network/end/points.dart';
import 'package:shop_store/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  LoginModel? login;
  IconData suffixIcon = Icons.visibility;
  bool passwordShow = true;
  void loginUser({required String email, required String password})
  {
    emit(LoadingLogin());
    DioHelper.postData(url:LOGIN, data:{
      'email':email,
      'password':password,
    }
    ).then((value){
      login = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(login!));
    }).catchError((error){
      print(error.toString());
      emit(LoginFailedState(error.toString()));
    });
  }
  void changePasswordIcon()
  {
    passwordShow = !passwordShow;
    suffixIcon = passwordShow?Icons.visibility:Icons.visibility_off_outlined;
    emit(ChangePasswordVisState());
  }



}