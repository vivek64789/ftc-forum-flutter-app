import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/login/login_cubit.dart';
import 'package:ftc_forum/repositories/auth_repository.dart';
import 'package:ftc_forum/screens/login/widgets/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: LoginScreen());
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => LoginCubit(
          context.read<AuthRepository>(),
        ),
        child: const Body(),
      ),
    );
  }
}
