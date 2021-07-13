import 'package:crypto_app_project/app_routing.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

// ignore: use_key_in_widget_constructors

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Bitcoin ',
              body:
                  'Bitcoin is a very exciting development, it might lead to a world currency.I think over the next decade it will grow to become one of the most important ways to pay for things and transfer assets.',
              image: buildImage('assets/images/1234.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Crypto Coin App',
              body: 'App to make it easier for you to track coin',
              image: buildImage('assets/images/coin2.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Simple UI',
              body: 'For enhanced reading experience',
              image: buildImage('assets/images/coin4.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Read', style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text(
            'Skip',
          ),
          onSkip: () => goToHome(context),
          next: Icon(
            Icons.arrow_forward,
          ),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          // globalBackgroundColor: Theme.of(context).primaryColor,
          skipFlex: 0,
          nextFlex: 0,
        ),
      );

  void goToHome(context) =>
      Navigator.pushNamed(context, RouteDefine.splashScreen.name);

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
