abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged({required this.username});
}

class LoginPasswordchanged extends LoginEvent {
  final String password;

  LoginPasswordchanged({required this.password});
}

class LoginSubmit extends LoginEvent {}
