import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/firebase_options.dart';
import 'package:ftc_forum/repositories/auth_repository.dart';
import 'package:ftc_forum/screens/screens.dart';

void main() async {
  setUp(() {});
  WidgetsFlutterBinding.ensureInitialized();
  Widget createWidgetUserTest() {
    return RepositoryProvider.value(
      value: AuthRepository(),
      child: BlocProvider(
        create: (_) => AppBloc(
          authRepository: AuthRepository(),
        ),
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );
  }

  
}
