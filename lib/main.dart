import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_state.dart';
import 'package:incident_reporter/bloc/simple_bloc_observer.dart';
import 'package:incident_reporter/repo/user_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: MyApp(
        userRepository: userRepository,
      )));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Incident Reporter',
        theme: ThemeData(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationFailure) {
              return Login(
                userRepository: _userRepository,
              );
            }
            if (state is AuthenticationSuccess) {
              return Home();
              //Home(user: state.firebaseUser);
            }

            return Home();
            // Scaffold(
            //   body: Center(
            //     child: Container(
            //       child: CircularProgressIndicator(),
            //     ),
            //   ),
            // );
          },
        ));
  }
}
