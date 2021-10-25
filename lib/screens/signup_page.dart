import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/register/register_bloc.dart';
import 'package:incident_reporter/repo/user_repo.dart';
import 'package:incident_reporter/screens/login_page.dart';
import 'package:incident_reporter/widgets/signup_form.dart';

class SignUp extends StatelessWidget {
  final UserRepository _userRepository;

  const SignUp({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(userRepository: _userRepository),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: SignupForm(
                userRepository: _userRepository,
              ),
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
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) {
                return Login(
                  userRepository: _userRepository,
                );
              }),
            ));
  }
}
