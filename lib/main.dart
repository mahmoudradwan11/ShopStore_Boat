import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/modules/login/login.dart';
import 'package:shop_store/modules/onboarding/onboarding.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';
import 'package:shop_store/shared/network/end/points.dart';
import 'package:shop_store/shared/network/local/cache.dart';
import 'package:shop_store/shared/network/remote/dio_helper.dart';
import 'package:shop_store/shared/styles/themes.dart';
import 'layout/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  Widget widget;
  var onBoarding = CacheHelper.getData(key: 'onBoarding');
  print(onBoarding);
  token = CacheHelper.getData(key: 'token');
  print('Token = $token');
  if (onBoarding != null) {
    if (token != null) {
      widget = const Home();
    } else {
      widget = Login();
    }
  } else {
    widget = const OnBoarding();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({Key? key, this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoatCubit()
        ..getHomeData()
        ..getCategory()
        ..createDatabase()
        ..getUserData()
        ..getOrders()
        ..getNotification(),
      child: BlocConsumer<BoatCubit, BoatStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Boat',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              themeMode: ThemeMode.light,
              darkTheme: darkTheme,
              home: AnimatedSplashScreen(
                splash: logo(),
                duration: 2500,
                nextScreen: startWidget!,
                splashTransition: SplashTransition.fadeTransition,
                backgroundColor: Colors.white,
                //type: AnimatedSplashType.StaticSplashScreen,
              ),
            );
          }),
    );
  }
}
