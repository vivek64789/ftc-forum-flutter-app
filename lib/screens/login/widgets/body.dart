import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ftc_forum/cubits/login/login_cubit.dart';
import 'package:ftc_forum/screens/login/widgets/background.dart';
import 'package:ftc_forum/screens/mainscreen/main_screen.dart';
import 'package:ftc_forum/screens/register/register_screen.dart';
import 'package:ftc_forum/widgets/already_have_an_account_acheck.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';
import 'package:ftc_forum/widgets/rounded_input_field.dart';
import 'package:ftc_forum/widgets/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("You are successfully Logged in"),
                ),
              );
            } else if (state.status == LoginStatus.error) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      title: Text("There is some error"),
                    );
                  });
            } else {
              print("Login Else");
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
                child: Image.asset("assets/images/logo.png"),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Welcome to FTC Forum",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "Login to your Account",
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/images/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return RoundedInputField(
                    key: const Key('loginEmail'),
                    hintText: "Your Email",
                    onChanged: (value) {
                      context.read<LoginCubit>().emailChanged(value);
                    },
                  );
                },
              ),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return RoundedPasswordField(
                    key: const Key('loginPassword'),
                    onChanged: (value) {
                      context.read<LoginCubit>().passwordChanged(value);
                    },
                  );
                },
              ),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return state.status == LoginStatus.loading
                      ? const CircularProgressIndicator()
                      : RoundedButton(
                        key: const Key('loginButton'),
                          text: "LOGIN",
                          press: () {
                            context
                                .read<LoginCubit>()
                                .loginWithEmailAndPassword();
                          },
                        );
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                key: const Key('registerScreen'),
                press: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
