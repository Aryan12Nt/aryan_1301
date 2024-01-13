part of 'auth_bloc.dart';

@immutable
abstract class SignInEmailEvent {}

class SignInWithEmailPassword extends SignInEmailEvent {
  final String email;
  final String password;
  SignInWithEmailPassword({required this.email, required this.password});
}
