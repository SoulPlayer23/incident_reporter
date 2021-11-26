import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_event.dart';
import 'package:incident_reporter/bloc/auth/auth_state.dart';
import 'package:incident_reporter/repo/user_repo.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    // init();
    // on<AuthenticationStarted>((event, emit) =>
    //     emit(_mapAuthenticationStartedToState() as AuthenticationState));
    // on<AuthenticationLoggedIn>((event, emit) =>
    //     emit(_mapAuthenticationLoggedInToState() as AuthenticationState));
    // on<AuthenticationLoggedOut>((event, emit) =>
    //     emit(_mapAuthenticationLoggedOutToState() as AuthenticationState));
  }

  Future<void> init() async {
    this.add(AuthenticationStarted());
  }

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
    yield AuthenticationFailure('Authentication Failure');
    await userRepository.signOut();
  }

  //Authentication Logged In
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess((await userRepository.getUser())!);
  }

  //Authentication Started
  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await userRepository.isSignedIn();
    if (isSignedIn) {
      final firebaseUser = await userRepository.getUser();
      yield AuthenticationSuccess(firebaseUser!);
    } else {
      yield AuthenticationFailure('Authentication Failure');
    }
  }
}
