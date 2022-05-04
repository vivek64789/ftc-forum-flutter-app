import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ftc_forum/screens/login/widgets/background.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RegisterScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
