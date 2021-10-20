import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/auth/auth_cubit.dart';
import 'package:incident_reporter/screens/confirmation_page.dart';
import 'package:incident_reporter/screens/login_page.dart';
import 'package:incident_reporter/screens/signup_page.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          //Show Login
          if (state == AuthState.login) MaterialPage(child: Login()),

          //Allow push animation
          if (state == AuthState.signUp ||
              state == AuthState.confirmSignUp) ...[
            //Show Sign Up
            MaterialPage(child: SignUp()),

            //Show confirmation
            if (state == AuthState.confirmSignUp)
              MaterialPage(child: Confirmation())
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
