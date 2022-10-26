import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/layout/home.dart';
import 'package:shop_store/modules/register/register.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/network/end/points.dart';
import 'package:shop_store/shared/network/local/cache.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.model.status!) {
            print(state.model.message);
            print(state.model.data!.token);
            CacheHelper.saveData(key: 'token', value: state.model.data!.token)
                .then((value) {
              token = state.model.data!.token;
              showToast('${state.model.message}', ToastStates.SUCCESS);
              navigateAndFinish(context, const Home());
            });
          } else {
            print(state.model.message);
          }
        }
      }, builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
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
                    'Nice to see you',
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
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            const SizedBox(
                              height: 50,
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
                              height: 50,
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
                                  show: cubit.passwordShow,
                                  suffix: cubit.suffixIcon,
                                  suffixPress: () {
                                    cubit.changePasswordIcon();
                                  }),
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
                      cubit.loginUser(
                          email: emailController.text,
                          password: passwordController.text);
                    }
                  },
                  text: 'Login',
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
                        function: () {},
                        text: 'Login',
                        background: Colors.purpleAccent[200]!,
                        heigth: 60,
                        width: 150),
                  )),
              Positioned(
                  top: 350,
                  left: -60,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defButton(
                        function: () {
                          navigateTo(context,Register());
                        },
                        text: 'SignUp',
                        background: Colors.white,
                        heigth: 60,
                        width: 150,
                        textColor: Colors.black),
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
      }),
    );
  }
}
