import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_reporter/cubit/auth_cubit.dart';
import 'package:incident_reporter/auth/auth_navigator.dart';
import 'package:incident_reporter/model/session_state.dart';
import 'package:incident_reporter/screens/home_page.dart';
import 'package:incident_reporter/screens/loading_view.dart';
import 'package:incident_reporter/cubit/session_cubit.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: AuthNavigator(),
              ),
            ),

          // Show session flow
          if (state is Authenticated) MaterialPage(child: Home())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
