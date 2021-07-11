import 'package:crypto_app_project/config/navigation_util.dart';
import 'package:crypto_app_project/presentation/home/ui/home_screen.dart';
import 'package:crypto_app_project/presentation/login/bloc/login_bloc.dart';
import 'package:crypto_app_project/presentation/logout/bloc/logout_bloc.dart';
import 'package:crypto_app_project/presentation/register/bloc/register_bloc.dart';
import 'package:crypto_app_project/presentation/splash/onboarding_screen.dart';
import 'package:crypto_app_project/repositories/bloc/auth_bloc.dart';
import 'package:crypto_app_project/repositories/user_repositories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(UserRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationUtil.rootKey,
        // theme: ThemeData(primarySwatch: Colors.blue),
        home: MainScreen(),
      ),
    );
  }
}

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
