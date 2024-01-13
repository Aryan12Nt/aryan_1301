import 'dart:async';

import 'package:aryan_01/models/user_model.dart';
import 'package:aryan_01/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepo authRepo;
  SignUpBloc({required this.authRepo}) : super(SignUpInitial()) {
    on<SignUpWithEmailPassword>(_onSignUpWithEmailRequested);
    on<SignOutEvent>(_onSignOutRequested);
  }

  Future<void> _onSignUpWithEmailRequested(
    SignUpWithEmailPassword event,
    Emitter<SignUpState> emit,
  ) async {
    emit(LoadingState());
    try {
      UserModel user = await authRepo.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SignInSuccessState(user: user));
    } on Exception catch (e, stacktrace) {
      emit(SignInFailState(error: e.toString()));
      addError(e, stacktrace);
    }
  }
  Future<void> _onSignOutRequested(
      SignOutEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(LoadingState());
    try {
      await authRepo.signOut();
      emit(SignOutSuccessState());
    } catch (e) {
      emit(SignOutErrorState(error: e.toString()));
    }
  }
}
