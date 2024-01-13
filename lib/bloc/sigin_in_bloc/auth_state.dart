part of 'auth_bloc.dart';

@immutable
abstract class SignInEmailState {}

class SignInEmailInitial extends SignInEmailState {}

class SignInSuccessState extends SignInEmailState {
  final UserModel user;
  SignInSuccessState({required this.user});
}

class SignInFailState extends SignInEmailState {
  String error;
  SignInFailState({required this.error});
}

class LoadingState extends SignInEmailState {}
