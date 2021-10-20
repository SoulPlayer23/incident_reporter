import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/auth/auth_credentials.dart';
import 'package:incident_reporter/model/session_state.dart';
import 'package:incident_reporter/repo/auth_repo.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository? authRepo;
  SessionCubit({this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo!.attemptAutoLogin();
      final user = userId;
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) {
    emit(Authenticated(user: credentials.username));
  }

  void signOut() {
    authRepo!.signOut();
    emit(Unauthenticated());
  }
}
