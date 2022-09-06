import 'package:ecommerce_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:ecommerce_app/shared/network/remote/dio/dio_helper.dart';
import 'package:ecommerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  DioHelper.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
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
        fontFamily: "jannah"
      ),
    );
  }
}
