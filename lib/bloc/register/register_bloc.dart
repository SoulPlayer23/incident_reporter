import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/repo/user_repo.dart';
import 'package:incident_reporter/utils/validators.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
    // on<RegisterEmailChange>((event, emit) =>
    //     emit(_mapRegisterEmailChangeToState(event.email) as RegisterState));
    // on<RegisterPasswordChange>((event, emit) => emit(
    //     _mapRegisterPasswordChangeToState(event.password) as RegisterState));
    // on<RegisterSubmitted>((event, emit) => emit(
    //     _mapRegisterWithCredentialsPressedToState(
    //         email: event.email, password: event.password) as RegisterState));
  }

  @override
  Stream<RegisterState> mapEventtoState(RegisterEvent event) async* {
    if (event is RegisterEmailChange) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChange) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield RegisterState.loading();
    try {
      await UserRepository().signInWithCredentials(email, password);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
