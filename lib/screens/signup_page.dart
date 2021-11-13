import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/register/register_bloc.dart';
import 'package:incident_reporter/screens/login_page.dart';
import 'package:incident_reporter/widgets/signup_form.dart';

class SignUp extends StatelessWidget {
  static final route = "/signup";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: SignupForm(),
              margin: EdgeInsets.only(top: height * 0.5),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            _showLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _showLoginButton(BuildContext context) {
    return TextButton(
      child: Text('Already have an account? Sign in.'),
      onPressed: () => Navigator.pushReplacementNamed(context, Login.route),
    );
  }
}
