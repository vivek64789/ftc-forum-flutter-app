import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/register/register_cubit.dart';
import 'package:ftc_forum/repositories/auth_repository.dart';
import 'package:ftc_forum/screens/register/widgets/body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => RegisterCubit(context.read<AuthRepository>()),
        child: Body(),
      ),
    );
  }
}
