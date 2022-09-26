import 'package:ecommerce_app/layout/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/layout/home_cubit/home_states.dart';
import 'package:ecommerce_app/layout/home_screen.dart';
import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:ecommerce_app/shared/components/constants.dart';
import 'package:ecommerce_app/shared/network/local/cache_helper.dart';
import 'package:ecommerce_app/shared/network/remote/dio/dio_helper.dart';
import 'package:ecommerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print("the token is $token");
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


  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  late Widget startWidget;

  MyApp(this.startWidget, {Key? key}) : super(key: key); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData()),
      ],
      child: BlocConsumer<HomeCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: defaultColor,
                  type: BottomNavigationBarType.fixed,
                ),
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
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  color: Colors.white,
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
                ),
                fontFamily: "jannah"),
          );
        },
      ),
    );
  }
}
