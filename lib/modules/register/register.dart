import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/layout/home.dart';
import 'package:shop_store/modules/login/login.dart';
import 'package:shop_store/modules/register/cubit/cubit.dart';
import 'package:shop_store/modules/register/cubit/states.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/network/end/points.dart';
import 'package:shop_store/shared/network/local/cache.dart';

class Register extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              showToast(state.loginModel.message!, ToastStates.SUCCESS);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(
                  context,
                  const Home(),
                );
              });
            } else {
              print(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff955cd1),
                        Color(0xff3fa2fa),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  top: -60,
                  left: -20,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundColor: Colors.white,
                    child: Text(
                      'Welcome ',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: -20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey[300]!,
                          const Color(0xff3fa2fa),
                        ],
                      ),
                    ),
                    height: 600,
                    width: 300,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Signup',
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Email',
                                style:
                                TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Container(
                                height: 60,
                                width: 250,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey[500]!,
                                      const Color(0xff3fa2fa),
                                    ],
                                  ),
                                ),
                                child: defaultFieldForm(
                                  controller: emailController,
                                  keyboard: TextInputType.emailAddress,
                                  valid: (value) {
                                    if (value.isEmpty) {
                                      return 'Email Must not be Empty';
                                    }
                                    return null;
                                  },
                                  show: false,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Password',
                                style:
                                TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Container(
                                height: 60,
                                width: 250,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey[500]!,
                                      const Color(0xff3fa2fa),
                                    ],
                                  ),
                                ),
                                child: defaultFieldForm(
                                    controller: passwordController,
                                    keyboard: TextInputType.visiblePassword,
                                    valid: (value) {
                                      if (value.isEmpty) {
                                        return 'Password Must not be Empty';
                                      }
                                      return null;
                                    },
                                    show: cubit.isPassword,
                                    suffix: cubit.suffix,
                                    suffixPress: () {
                                      cubit.changePasswordVisibility();
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Name',
                                style:
                                TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Container(
                                height: 60,
                                width: 250,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey[500]!,
                                      const Color(0xff3fa2fa),
                                    ],
                                  ),
                                ),
                                child: defaultFieldForm(
                                  controller: nameController,
                                  keyboard: TextInputType.text,
                                  valid: (value) {
                                    if (value.isEmpty) {
                                      return 'Name Must not be Empty';
                                    }
                                    return null;
                                  },
                                  show: false,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Phone',
                                style:
                                TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Container(
                                height: 60,
                                width: 250,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey[500]!,
                                      const Color(0xff3fa2fa),
                                    ],
                                  ),
                                ),
                                child: defaultFieldForm(
                                  controller: phoneController,
                                  keyboard: TextInputType.phone,
                                  valid: (value) {
                                    if (value.isEmpty) {
                                      return 'Phone Must not be Empty';
                                    }
                                    return null;
                                  },
                                  show: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 670,
                  left: 150,
                  child: defButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        cubit.userRegister(
                            name: nameController.text,
                            email: emailController.text,
                            phone:phoneController.text,
                            password: passwordController.text);
                      }
                    },
                    text: 'SignUp',
                    width: 200,
                    heigth: 50,
                    isUpper: true,
                    background: Colors.white.withOpacity(0.9),
                    textColor: Colors.black,
                  ),
                ),
                Positioned(
                    top: 250,
                    left: -60,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defButton(
                          function: () {
                            navigateTo(context,Login());
                          },
                          text: 'Login',
                          background: Colors.white,
                          heigth: 60,
                          width: 150,textColor: Colors.black
                      ),
                    )),
                Positioned(
                    top: 350,
                    left: -60,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defButton(
                          function: (){},
                          text: 'SignUp',
                          background:Colors.purpleAccent[200]!,
                          heigth: 60,
                          width: 150,
                          textColor: Colors.white),
                    )),
                const Positioned(
                  top: 450,
                  child: Icon(Icons.facebook,size:65,color: Colors.white,),
                ),
                const Positioned(
                  top: 530,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:AssetImage('images/ggogle.png'),
                  ),
                ),
                const Positioned(
                  top: 610,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:AssetImage('images/twitter.png'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}