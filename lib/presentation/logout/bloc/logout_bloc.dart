import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app_project/repositories/user_repositories.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  UserRepository userRepository;
  LogoutBloc(
    this.userRepository,
  ) : super(LogoutInitial());

  @override
  Stream<LogoutState> mapEventToState(
    LogoutEvent event,
  ) async* {
    if (event is LogOutEvent) {
      userRepository.signOut();
      yield LogOutSucced();
    }
  }
}
