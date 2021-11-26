import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_state.dart';

import 'home_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  static const route = "/";

  @override
  State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          _navigateToHome(context, user: state.firebaseUser);
        }

        return Login();
      },
    );
  }

  void _navigateToHome(BuildContext context, {required User user}) {
    Navigator.pushReplacementNamed(context, Home.route,
        arguments: HomeArgument(user: user));
  }
}
