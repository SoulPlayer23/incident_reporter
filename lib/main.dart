import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/bloc/auth/auth_bloc.dart';
import 'package:incident_reporter/bloc/simple_bloc_observer.dart';
import 'package:incident_reporter/repo/user_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:incident_reporter/routes.dart';
import 'package:incident_reporter/screens/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AuthenticationBloc(userRepository: UserRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Incident Reporter',
        theme: ThemeData(),
        routes: routes,
        initialRoute: SplashPage.route,
      ),
    );
  }
}
