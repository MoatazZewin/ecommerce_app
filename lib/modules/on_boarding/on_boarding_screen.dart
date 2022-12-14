import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class OnBoardingModel {
  String title;
  String body;
  String image;

  OnBoardingModel(
      {required this.title, required this.body, required this.image});
}

class OnBoardingScreen extends StatelessWidget {
  var isLast = false;
  var pageController = PageController();
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
        title: 'On board 1 Title ',
        body: 'On Board 1 Body',
        image: 'assets/images/onboard_1.jpg'),
    OnBoardingModel(
        title: 'On board 2 Title ',
        body: 'On Board 2 Body',
        image: 'assets/images/onboard_1.jpg'),
    OnBoardingModel(
        title: 'On board 3 Title ',
        body: 'On Board 3 Body',
        image: 'assets/images/onboard_1.jpg'),
  ];

  void onSubmit(context){
    CacheHelper.setData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context: context, widget: LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              onSubmit(context);
            },
            child: const Text(
              'SKIP',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                  return buildBoardingItem(boarding[index]);
                },
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                    activeDotColor: defaultColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      onSubmit(context);
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(list) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage("${list.image}"),
            ),
          ),
          Text(
            '${list.title}',
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '${list.body}',
            style: const TextStyle(
              fontSize: 10.0,
            ),
          ),
        ],
      );
}
