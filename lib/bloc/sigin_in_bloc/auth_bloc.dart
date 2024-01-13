import 'package:aryan_01/models/user_model.dart';
import 'package:aryan_01/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class SignInEmailBloc extends Bloc<SignInEmailEvent, SignInEmailState> {
  AuthRepo authRepo;
  SignInEmailBloc({required this.authRepo}) : super(SignInEmailInitial()) {
    on<SignInWithEmailPassword>(_onSignInWithEmailRequested);
  }

  Future<void> _onSignInWithEmailRequested(
      SignInWithEmailPassword event,
      Emitter<SignInEmailState> emit,
      ) async {
    emit(LoadingState());
    try {
      UserModel user = await AuthRepo().signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SignInSuccessState(user: user));
    } on Exception catch (e, stacktrace) {
      emit(SignInFailState(error: e.toString()));
      addError(e, stacktrace);
    }
  }
}
