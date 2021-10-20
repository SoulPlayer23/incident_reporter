import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/auth/auth_cubit.dart';
import 'package:incident_reporter/auth/form_submission_status.dart';
import 'package:incident_reporter/auth/signup/signup_event.dart';
import 'package:incident_reporter/model/signup_state.dart';
import 'package:incident_reporter/repo/auth_repo.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit? authCubit;

  SignUpBloc({required this.authRepo, this.authCubit}) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // Username updated
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Email updated
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.signUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());
        authCubit!.showConfirmSignUp(
            username: state.username,
            password: state.password,
            email: state.email);
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
