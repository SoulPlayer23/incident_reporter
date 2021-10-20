import 'package:incident_reporter/auth/auth_credentials.dart';
import 'package:incident_reporter/auth/auth_cubit.dart';
import 'package:incident_reporter/auth/form_submission_status.dart';
import 'package:incident_reporter/auth/login/login_event.dart';
import 'package:incident_reporter/model/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/repo/auth_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepo;
  final AuthCubit? authCubit;
  LoginBloc({this.authRepo, this.authCubit}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    //username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordchanged) {
      //password updated
      yield state.copyWith(password: event.password);
      //form submitted
    } else if (event is LoginSubmit) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo!
            .login(username: state.username, password: state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit!.launchSession(
            AuthCredentials(username: state.username, userId: userId));
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
