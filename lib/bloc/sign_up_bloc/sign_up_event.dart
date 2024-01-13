part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}
class SignUpWithEmailPassword extends SignUpEvent {
  final String email;
  final String password;
  SignUpWithEmailPassword({required this.email, required this.password});
}
class SignOutEvent extends SignUpEvent {}