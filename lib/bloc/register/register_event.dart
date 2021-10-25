import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterEmailChange extends RegisterEvent {
  final String email;

  RegisterEmailChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChange extends RegisterEvent {
  final String password;

  RegisterPasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;

  RegisterSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
