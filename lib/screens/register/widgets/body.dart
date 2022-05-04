import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:ftc_forum/screens/login/login_screen.dart';
import 'package:ftc_forum/screens/register/widgets/background.dart';
import 'package:ftc_forum/screens/register/widgets/or_divider.dart';
import 'package:ftc_forum/screens/register/widgets/social_icon.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
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
            // OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocalIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
