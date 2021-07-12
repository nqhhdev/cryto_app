import 'package:crypto_app_project/presentation/home/ui/home_screen.dart';
import 'package:crypto_app_project/presentation/splash/onboarding/onboarding_screen.dart';
import 'package:crypto_app_project/repositories/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return OnBoardingScreen();
        }
        if (state is UnAuthenticateState) {
          return OnBoardingScreen();
        } else if (state is AuthenticateState) {
          return const HomeScreen();
        }
        return Container();
      },
    );
  }
}
