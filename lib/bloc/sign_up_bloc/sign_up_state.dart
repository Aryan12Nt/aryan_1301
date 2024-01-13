part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignInEmailInitial extends SignUpState {}

class SignInSuccessState extends SignUpState {
  final UserModel user;
  SignInSuccessState({required this.user});
}

class SignInFailState extends SignUpState {
  String error;
  SignInFailState({required this.error});
}

class LoadingState extends SignUpState {}

class SignOutSuccessState extends SignUpState {}

class SignOutErrorState extends SignUpState {
  String error;
  SignOutErrorState({required this.error});
}
