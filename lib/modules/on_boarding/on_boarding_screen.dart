import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class OnBoardingScreen extends StatelessWidget {

  var controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'On Boarding',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                  itemBuilder: (context, index)=>buildBoardingItem(),
                  itemCount: 3,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [

                SmoothPageIndicator(controller: controller, count: 3),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){},
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            )


          ],
        ),
      ),
    );
  }
  Widget buildBoardingItem() =>Column(
    children: [
      Expanded(
        child: Image(
          image: AssetImage("assets/images/onboard_1.jpg"),
        ),
      ),
      Text(
        'Board Title 1',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        'board body',
        style: TextStyle(

        ),
      ),
    ],
  );
}
