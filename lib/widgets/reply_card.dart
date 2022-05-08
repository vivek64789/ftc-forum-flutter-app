import 'package:flutter/material.dart';
import 'package:ftc_forum/constants.dart';
import 'package:ftc_forum/widgets/avatar_image.dart';
import 'package:ftc_forum/widgets/vote_button.dart';

class ReplyCard extends StatelessWidget {
  final String profileUrl;
  final String date;
  final String reply;
  final String upvotes;
  final String downvotes;
  final String comments;
  final Function onPress;
  final Color bgColor, textColor;
  ReplyCard({
    Key? key,
    required this.profileUrl,
    required this.date,
    required this.reply,
    this.upvotes = "0",
    this.downvotes = "0",
    this.comments = "0",
    required this.onPress,
    this.bgColor = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.01),
          padding: EdgeInsets.all(size.width * 0.03),
          // height: size.height * 0.2,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(size.height * 0.01),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarImage(
                      height: size.height * 0.05, profileUrl: profileUrl),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bibekanand Kushwaha",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "2022-03-4",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Programming is something that you don't know",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      VoteButton(
                        icon: Icons.thumb_up,
                        isSelected: false,
                        onPress: () {},
                      ),
                      Text(
                        1.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      VoteButton(
                        icon: Icons.thumb_down,
                        isSelected: true,
                        onPress: () {},
                      ),
                      Text(
                        1.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
