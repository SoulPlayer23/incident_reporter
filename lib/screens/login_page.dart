import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/login/login_bloc.dart';
import 'package:incident_reporter/screens/signup_page.dart';
import 'package:incident_reporter/widgets/login_form.dart';

class Login extends StatelessWidget {
  static const route = "/login";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: LoginForm(),
              margin: EdgeInsets.only(top: height * 0.5),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            _signupButton(context),
          ],
        ),
      ),
    );
  }

  Widget _signupButton(BuildContext context) {
    return TextButton(
        onPressed: () =>
            {Navigator.pushReplacementNamed(context, SignUp.route)},
        child: Text('Don\'t have an account? Sign up'));
  }
}
