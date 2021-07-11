import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app_project/repositories/user_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;
  RegisterBloc(this.userRepository) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SignUp) {
      yield RegisterLoading();

      try {
        var user = await userRepository.signUp(
          event.named,
          event.phoneNumber,
          event.email,
          event.password,
        );
        print("User : ${user.toString()}");
        yield RegisterSucced(user: user!);
      } catch (e) {
        yield RegisterFailed(message: e.toString());
      }
    }
  }
}
