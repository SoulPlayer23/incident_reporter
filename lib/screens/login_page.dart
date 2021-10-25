import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/login/login_bloc.dart';
import 'package:incident_reporter/repo/user_repo.dart';
import 'package:incident_reporter/screens/signup_page.dart';
import 'package:incident_reporter/widgets/login_form.dart';

class Login extends StatelessWidget {
  final UserRepository _userRepository;

  const Login({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: LoginForm(
                userRepository: _userRepository,
              ),
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
        onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SignUp(
                  userRepository: _userRepository,
                );
              }))
            },
        child: Text('Don\'t have an account? Sign up'));
  }
}
