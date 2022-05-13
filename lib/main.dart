import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/bloc_observer.dart';
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/config/route_generator.dart';
import 'package:ftc_forum/config/routes.dart';
import 'package:ftc_forum/config/theme.dart';
import 'package:ftc_forum/firebase_options.dart';
import 'package:ftc_forum/repositories/repositories.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final authRepository = AuthRepository();
      runApp(App(authRepository: authRepository));
    },
    blocObserver: AppBlocObserver(),
  );
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  const App({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authRepository: _authRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: theme(),
      home: FlowBuilder(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages),
    );
  }
}
