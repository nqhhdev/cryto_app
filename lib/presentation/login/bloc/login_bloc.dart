import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app_project/repositories/user_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc(this.userRepository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignIn) {
      yield LoginLoading();

      await Future.delayed(const Duration(seconds: 1));
      try {
        var user = await userRepository.signIn(
          event.email,
          event.password,
        );

        print("User : ${user.toString()}");
        yield LoginSucced(user: user!);
      } catch (e) {
        yield LoginFailed(message: e.toString());
      }
    }
  }
}
