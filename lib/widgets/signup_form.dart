import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_event.dart';
import 'package:incident_reporter/bloc/register/register_bloc.dart';
import 'package:incident_reporter/bloc/register/register_event.dart';
import 'package:incident_reporter/bloc/register/register_state.dart';
import 'package:incident_reporter/repo/user_repo.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late UserRepository userRepository;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  late RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {}
        if (state.isSubmitting) {}
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    decoration: InputDecoration(icon: Icon(Icons.person)),
                  ),
                  TextFormField(
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    decoration: InputDecoration(icon: Icon(Icons.password)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (isButtonEnabled(state)) {
                          _onFormSubmitted();
                        }
                      },
                      child: Text('Sign Up'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChange(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChange(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(RegisterSubmitted(
        email: _emailController.text, password: _passwordController.text));
  }
}
