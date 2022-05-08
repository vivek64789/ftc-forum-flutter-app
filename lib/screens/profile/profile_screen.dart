import 'package:flutter/material.dart';
import 'package:ftc_forum/widgets/avatar_image.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(size.width * 0.03),
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.height * 0.01),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AvatarImage(
                      height: size.height * 0.10,
                      profileUrl:
                          'https://scontent.fktm14-1.fna.fbcdn.net/v/t39.30808-6/272884280_1322680931491192_2978946894628018774_n.jpg?_nc_cat=111&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=vCmlCAvdjUcAX9cy_Rs&tn=E-f_5F5sH7BOU_5c&_nc_ht=scontent.fktm14-1.fna&oh=00_AT_8Jxrl_WOzkqOU8go1_ws_qH1N7R5F7yKIGtfguJNrDQ&oe=62796ABD',
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bibekanand Kushwaha",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        "vivek@gmail.com",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: EdgeInsets.all(size.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileListItem(
                      caption: "DOB:",
                      title: "2022-02-22",
                    ),
                    ProfileListItem(
                      caption: "Email",
                      title: "vivek@gmail.com",
                    ),
                    ProfileListItem(
                      caption: "Phone",
                      title: "9818821313",
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(text: "Logout", press: () {})
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  String title;
  String caption;
  ProfileListItem({
    Key? key,
    required this.title,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}
