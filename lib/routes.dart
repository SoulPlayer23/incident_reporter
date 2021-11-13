import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/register/register_bloc.dart';
import 'package:incident_reporter/screens/home_page.dart';
import 'package:incident_reporter/screens/login_page.dart';
import 'package:incident_reporter/screens/signup_page.dart';
import 'package:incident_reporter/screens/splash_page.dart';

import 'bloc/login/login_bloc.dart';

final routes = {
  SplashPage.route: (context) => SplashPage(),
  Home.route: (context) => Home(),
  Login.route: (context) => BlocProvider(
        create: (_) => LoginBloc(),
        child: Login(),
      ),
  SignUp.route: (context) => BlocProvider(
        create: (_) => RegisterBloc(),
        child: SignUp(),
      )
};
