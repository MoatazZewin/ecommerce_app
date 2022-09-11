import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          defaultButton(
              text: "signout",
              onPressed: () {
                CacheHelper.remove(key: 'token').then((value) {
                  if (value) {
                    navigateAndFinish(context: context, widget: LoginScreen());
                  }
                });
              }),
        ],
      ),
    );
  }
}
