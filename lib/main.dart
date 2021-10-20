import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/navigator.dart';
import 'package:incident_reporter/repo/auth_repo.dart';
import 'package:incident_reporter/session_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Incident Reporter',
        theme: ThemeData(),
        home: RepositoryProvider(
          create: (context) => AuthRepository(),
          child: BlocProvider(
            create: (context) =>
                SessionCubit(authRepo: context.read<AuthRepository>()),
            child: AppNavigator(),
          ),
        ));
  }
}
