abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class initialFormStatus extends FormSubmissionStatus {
  const initialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final Object exception;

  SubmissionFailed(this.exception);
}
