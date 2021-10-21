import 'package:bloc/bloc.dart';
import 'package:incident_reporter/cubit/auth_cubit.dart';
import 'package:incident_reporter/auth/confirm/confirmation_event.dart';
import 'package:incident_reporter/auth/form_submission_status.dart';
import 'package:incident_reporter/model/confirmation_state.dart';
import 'package:incident_reporter/repo/auth_repo.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    // Confirmation code updated
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);

      // Form submitted
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo.confirmSignUp(
            username: authCubit.credentials!.username,
            confirmationCode: state.code);
        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authCubit.credentials;
        credentials!.userId = userId;

        authCubit.launchSession(credentials);
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
