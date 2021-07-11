part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

// ignore: must_be_immutable
class RegisterSucced extends RegisterState {
  User user;
  RegisterSucced({required this.user});
}

// ignore: must_be_immutable
class RegisterFailed extends RegisterState {
  String message;
  RegisterFailed({required this.message});
}
