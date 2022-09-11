import 'package:ecommerce_app/layout/home_screen.dart';
import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:ecommerce_app/shared/network/local/cache_helper.dart';
import 'package:ecommerce_app/shared/network/remote/dio/dio_helper.dart';
import 'package:ecommerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  Widget startWidget;
  if (onBoarding != null) {
    if (token != null) {
      startWidget = HomeScreen();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  late Widget startWidget;

  MyApp(this.startWidget); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidget,
      theme: ThemeData(
          primarySwatch: defaultColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: defaultColor,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            toolbarTextStyle: TextStyle(
              color: defaultColor,
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            color: Colors.white,
            iconTheme: IconThemeData(
              color: defaultColor,
            ),
          ),
          fontFamily: "jannah"),
    );
  }
}
