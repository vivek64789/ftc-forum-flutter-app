import 'package:flutter/material.dart';
import 'package:ftc_forum/widgets/reply_card.dart';
import 'package:ftc_forum/widgets/write_comment.dart';

class RepliesThread extends StatelessWidget {
  const RepliesThread({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WriteComment(size: size),
        SizedBox(
          height: size.height * 0.6,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://scontent.fktm14-1.fna.fbcdn.net/v/t39.30808-6/272884280_1322680931491192_2978946894628018774_n.jpg?_nc_cat=111&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=vCmlCAvdjUcAX9cy_Rs&tn=E-f_5F5sH7BOU_5c&_nc_ht=scontent.fktm14-1.fna&oh=00_AT_8Jxrl_WOzkqOU8go1_ws_qH1N7R5F7yKIGtfguJNrDQ&oe=62796ABD",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://scontent.fktm14-1.fna.fbcdn.net/v/t39.30808-6/272884280_1322680931491192_2978946894628018774_n.jpg?_nc_cat=111&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=vCmlCAvdjUcAX9cy_Rs&tn=E-f_5F5sH7BOU_5c&_nc_ht=scontent.fktm14-1.fna&oh=00_AT_8Jxrl_WOzkqOU8go1_ws_qH1N7R5F7yKIGtfguJNrDQ&oe=62796ABD",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://scontent.fktm14-1.fna.fbcdn.net/v/t39.30808-6/272884280_1322680931491192_2978946894628018774_n.jpg?_nc_cat=111&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=vCmlCAvdjUcAX9cy_Rs&tn=E-f_5F5sH7BOU_5c&_nc_ht=scontent.fktm14-1.fna&oh=00_AT_8Jxrl_WOzkqOU8go1_ws_qH1N7R5F7yKIGtfguJNrDQ&oe=62796ABD",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://scontent.fktm14-1.fna.fbcdn.net/v/t39.30808-6/272884280_1322680931491192_2978946894628018774_n.jpg?_nc_cat=111&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=vCmlCAvdjUcAX9cy_Rs&tn=E-f_5F5sH7BOU_5c&_nc_ht=scontent.fktm14-1.fna&oh=00_AT_8Jxrl_WOzkqOU8go1_ws_qH1N7R5F7yKIGtfguJNrDQ&oe=62796ABD",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
