part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SignUp extends RegisterEvent {
  final String email, password, named;
  String phoneNumber;
  SignUp({
    required this.email,
    required this.password,
    required this.named,
    required this.phoneNumber,
  });
}
