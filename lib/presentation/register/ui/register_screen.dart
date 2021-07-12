import 'package:crypto_app_project/app_routing.dart';
import 'package:crypto_app_project/presentation/home/ui/home_screen.dart';

import 'package:crypto_app_project/presentation/register/bloc/register_bloc.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterBloc registerBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namedController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    registerBloc = BlocProvider.of<RegisterBloc>(context);

    return ScreenUtilInit(
      builder: () => HomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final purpleColor = const Color(0xff6688FF);

  final darkTextColor = const Color(0xff1F1A3D);

  final lightTextColor = const Color(0xff999999);

  final textFieldColor = const Color(0xffF5F6FA);

  final borderColor = const Color(0xffD9D9D9);

  @override
  Widget build(BuildContext context) {
    late RegisterBloc registerBloc;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController namedController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52.h,
              ),
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSucced) {
                    const snackBar = SnackBar(content: Text('Success'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    emailController.text = '';
                    passwordController.text = '';
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()));
                  } else if (state is RegisterFailed) {
                    const snackBar = SnackBar(content: Text('error!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              ),
              Text(
                "Register to Cryto Coin",
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
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: purpleColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              TextField(
                keyboardType: TextInputType.name,
                controller: namedController,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: "Full Name",
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 8.h,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: "Phone Numbers",
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 8.h,
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
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                    registerBloc.add(
                      SignUp(
                        named: namedController.text,
                        phoneNumber: phoneNumberController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(purpleColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 14.h)),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ))),
                  child: const Text("Create Account"),
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
                          Navigator.pop(context);
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
                        child: const Text("LogIn Screen"),
                      ),
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                        child: const Text("Plash Screen"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Wrap(
                children: [
                  Center(
                    child: Text(
                      "Those who don't play never WIN",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange[600],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "terms and conditions",
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w700,
                        color: purpleColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
