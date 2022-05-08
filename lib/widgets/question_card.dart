import 'package:flutter/material.dart';
import 'package:ftc_forum/constants.dart';
import 'package:ftc_forum/widgets/replies_thread.dart';
import 'package:ftc_forum/widgets/vote_button.dart';

class QuestionCard extends StatefulWidget {
  final String profileUrl;
  final String date;
  final String title;
  final String description;
  final String upvotes;
  final String downvotes;
  final String comments;
  final String category;
  final Function onPress;
  final Color bgColor, textColor;
  QuestionCard({
    Key? key,
    required this.profileUrl,
    required this.date,
    required this.title,
    required this.description,
    this.upvotes = "0",
    this.downvotes = "0",
    this.comments = "0",
    required this.onPress,
    this.category = "General",
    this.bgColor = Colors.white,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool isCommentActive = false;

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
            color: widget.bgColor,
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
                  SizedBox(
                    height: size.height * 0.05,
                    child: ClipOval(
                      child: Image.network(
                          'https://scontent.fktm14-1.fna.fbcdn.net/v/t39.30808-6/272884280_1322680931491192_2978946894628018774_n.jpg?_nc_cat=111&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=vCmlCAvdjUcAX9cy_Rs&tn=E-f_5F5sH7BOU_5c&_nc_ht=scontent.fktm14-1.fna&oh=00_AT_8Jxrl_WOzkqOU8go1_ws_qH1N7R5F7yKIGtfguJNrDQ&oe=62796ABD'),
                    ),
                  ),
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
                      "What is Programming",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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
                      VoteButton(
                        icon: Icons.comment,
                        isSelected: false,
                        onPress: () {
                          setState(() {
                            isCommentActive = !isCommentActive;
                          });
                        },
                      ),
                      Text(
                        1.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Text(
                    "Web Development",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              // Only show when comment is active
              isCommentActive ? RepliesThread(size: size) : Container()
            ],
          ),
        ),
      ],
    );
  }
}
