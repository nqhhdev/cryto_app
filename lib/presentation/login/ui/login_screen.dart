import 'package:crypto_app_project/commion/loading_dialog.dart';
import 'package:crypto_app_project/presentation/home/ui/home_screen.dart';
import 'package:crypto_app_project/presentation/login/bloc/login_bloc.dart';
import 'package:crypto_app_project/presentation/register/ui/register_screen.dart';
import 'package:crypto_app_project/presentation/splash/splash_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => LogInHome(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class LogInHome extends StatefulWidget {
  @override
  _LogInHomeState createState() => _LogInHomeState();
}

class _LogInHomeState extends State<LogInHome> {
  final purpleColor = const Color(0xff6688FF);

  final darkTextColor = const Color(0xff1F1A3D);

  final lightTextColor = const Color(0xff999999);

  final textFieldColor = const Color(0xffF5F6FA);

  final borderColor = const Color(0xffD9D9D9);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  late LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (listenerContext, state) {
        switch (state.runtimeType) {
          case LoginSucced:
            LoadingDialog.hideLoadingDialog;
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
            break;
          case LoginFailed:
            print("Login Error");
            const snackBar = SnackBar(content: Text('No Account'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            LoadingDialog.hideLoadingDialog;
            break;
          case LoginLoading:
            LoadingDialog.showLoadingDialog(listenerContext);
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Text(
                  "LogIn to Crypto Coin",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: darkTextColor,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Wrap(
                  children: [
                    Text(
                      "Already you ready ? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: lightTextColor,
                      ),
                    ),
                    Text(
                      "Lest Go",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: purpleColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.h),
                      filled: true,
                      fillColor: textFieldColor,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.h),
                      filled: true,
                      fillColor: textFieldColor,
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      loginBloc.add(
                        SignIn(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(purpleColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ))),
                    child: const Text("LogIn Account"),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      "or sign up via",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: lightTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const RegisterScreen()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(purpleColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 14.h)),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ))),
                          child: const Text("Register Screen"),
                        ),
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SplashScreen()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(purpleColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 14.h)),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ))),
                          child: const Text("Splash Screen"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Wrap(
                  children: [
                    Center(
                      child: Text(
                        "Terms and conditions",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: purpleColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Center(
                  child: Image.asset("assets/images/coin3.png"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
