import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/repo/user_repo.dart';
import 'package:incident_reporter/screens/home_page.dart';
import 'package:incident_reporter/screens/login_page.dart';

import 'bloc/login/login_bloc.dart';

final routes = {
  Home.route: (context) => Home(),
  Login.route: (context) => BlocProvider(
        create: (_) => LoginBloc(userRepository: UserRepository()),
        child: Login(),
      ),
};
