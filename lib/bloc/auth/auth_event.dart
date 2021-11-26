import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  // final User firebaseuser;

  // AuthenticationLoggedIn({required this.firebaseuser});

  // @override
  // List<Object> get props => [firebaseuser];
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
