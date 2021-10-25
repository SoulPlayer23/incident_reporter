import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_event.dart';
import 'package:incident_reporter/bloc/auth/auth_state.dart';
import 'package:incident_reporter/repo/user_repo.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventtoState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  //Authentication Logged Out
  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    _userRepository.signOut();
  }

  //Authentication Logged In
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess((await _userRepository.getUser())!);
  }

  //Authentication Started
  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final firebaseUser = await _userRepository.getUser();
      yield AuthenticationSuccess(firebaseUser!);
    } else {
      yield AuthenticationFailure();
    }
  }
}
