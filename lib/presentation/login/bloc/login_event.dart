part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends LoginEvent {
  final String email, password;
  const SignIn({
    required this.email,
    required this.password,
  });
}
