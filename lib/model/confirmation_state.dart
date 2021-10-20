import 'package:incident_reporter/auth/form_submission_status.dart';

class ConfirmationState {
  final String code;
  bool get isValidCode => code.length == 6;

  final FormSubmissionStatus formStatus;

  ConfirmationState({
    this.code = '',
    this.formStatus = const initialFormStatus(),
  });

  ConfirmationState copyWith({
    String? code,
    FormSubmissionStatus? formStatus,
  }) {
    return ConfirmationState(
      code: code ?? this.code,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
