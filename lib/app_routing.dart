import 'package:crypto_app_project/presentation/detail/detail_route.dart';
import 'package:crypto_app_project/presentation/favourites/favourites_screen_route.dart';
import 'package:crypto_app_project/presentation/home/home_screen_route.dart';
import 'package:crypto_app_project/presentation/login/login_screen_route.dart';
import 'package:crypto_app_project/presentation/register/register_screen_route.dart';
import 'package:crypto_app_project/presentation/splash/onboarding/onboarding_screen_route.dart';
import 'package:crypto_app_project/presentation/splash/splash/splash_screen_route.dart';
import 'package:crypto_app_project/repositories/ui/main_screen_route.dart';
import 'package:flutter/material.dart';

enum RouteDefine {
  mainScreen,
  onboardingScreen,
  splashScreen,
  loginScreen,
  registerScreen,
  homeScreen,
  detailScreen,
  favouritesScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.mainScreen.name: (_) => MainScreenRoute.route,
      RouteDefine.onboardingScreen.name: (_) => OnboardingScreenRoute.route,
      RouteDefine.splashScreen.name: (_) => SplashScreenRoute.route,
      RouteDefine.loginScreen.name: (_) => LogInScreenRoute.route,
      RouteDefine.registerScreen.name: (_) => RegisterScreenRoute.route,
      RouteDefine.homeScreen.name: (_) => HomeScreenRoute.route,
      RouteDefine.favouritesScreen.name: (_) => FavouritesScreenRoute.route,
      RouteDefine.detailScreen.name: (_) =>
          DetailFavoritesScreenRoute.route(settings.arguments as String),
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}

extension RouteExt on Object {
  String get name => toString().substring(toString().indexOf('.') + 1);
}
