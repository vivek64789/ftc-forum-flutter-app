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
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png",
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
