import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:ftc_forum/cubits/register/register_cubit.dart';
import 'package:ftc_forum/screens/login/login_screen.dart';
import 'package:ftc_forum/screens/register/widgets/background.dart';
import 'package:ftc_forum/widgets/already_have_an_account_acheck.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';
import 'package:ftc_forum/widgets/rounded_input_field.dart';
import 'package:ftc_forum/widgets/rounded_password_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.success) {
              print("Register Success");
            } else if (state.status == RegisterStatus.loading) {
              print("Register Loading");
            } else if (state.status == RegisterStatus.error) {
              print("Register Error");
            } else {
              print("Register Else");
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              SizedBox(
                height: 60,
                child: Image.asset("assets/images/logo.png"),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "New to FTC Forum?",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "Register your account",
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/images/register.svg",
                height: size.height * 0.35,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) => previous.name != current.name,
                builder: (context, state) {
                  return RoundedInputField(
                    icon: Icons.person,
                    hintText: "Your Name",
                    onChanged: (value) {
                      context.read<RegisterCubit>().nameChanged(value);
                    },
                  );
                },
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.phone != current.phone,
                builder: (context, state) {
                  return RoundedInputField(
                    icon: Icons.phone,
                    hintText: "Your Phone",
                    onChanged: (value) {
                      context.read<RegisterCubit>().phoneChanged(value);
                    },
                  );
                },
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) => previous.dob != current.dob,
                builder: (context, state) {
                  return RoundedInputField(
                    icon: Icons.date_range,
                    hintText: "Your DOB (DD/MM/YYYY)",
                    onChanged: (value) {
                      context.read<RegisterCubit>().dobChanged(value);
                    },
                  );
                },
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return state.status == RegisterStatus.loading
                      ? const CircularProgressIndicator()
                      : RoundedInputField(
                          icon: Icons.email,
                          hintText: "Your Email",
                          onChanged: (value) {
                            context.read<RegisterCubit>().emailChanged(value);
                          },
                        );
                },
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return RoundedPasswordField(
                    onChanged: (value) {
                      context.read<RegisterCubit>().passwordChanged(value);
                    },
                  );
                },
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return state.status == RegisterStatus.loading
                      ? const CircularProgressIndicator()
                      : RoundedButton(
                          text: "SIGNUP",
                          press: () {
                            context
                                .read<RegisterCubit>()
                                .registerWithEmailAndPassword();
                          },
                        );
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
