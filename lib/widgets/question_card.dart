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
                          'https://lh3.googleusercontent.com/gRLrC5v7WmqByiBdDvIaXF3x5m82KG6VbM1KT699kq6SJPLEXXMGPbgqYx2H5RhWUO9QR0jwqnfCcNgTCZdw1XLN0mVbxoYVe4HOlU0VBrkoBeC8TlA5qkFVOmenPJtZuDHUKz8oAYMQW4LXp4hBCv863hHNxylHgKZecbTmwr_UjxAj4zL2EA6no9jmCbzG2GW_96bcpz_0WQgy0p3UutgbF_8GbaEMAruRgX8FCPk4-v5EWcJW9n_UAxhTcIblDqybIb9uzrvHXOnf1mdv3vkAsx00OeX-jfVTqRdIGXZ6o_Ubv2wflswfMVgqHuh8pxz_N1yuMWPHk8xwJgzwCseuDS8wF0G80IU-grKYx98pxjiOo_zb4VmYwfVf6vbgl4cLe2VEFmLypoXni-BWSo4dXBgcHqgqBWdOoLq-pJDl0jeT9EsRbv5awSQ1cXX48O3Q4KwzmtqDk0i-7dFi7EIDOMiW0q8vZn1dsQ1J5AoRuxUmxK_Tqu0LoHL1hEN7FMVEz04OmmuFTbTD4CIaAS-7mCR8opBtSCPql0yDMhXAmWTIzJN3sbkDElWYwod8PS57m7Txve4w8zZf4YdvLeZYRzhqyDNSFWDvwlTf7mcSH8jIs__bRYQ9xfLsZu_nhS3wJOV7PCE-jXFL0jQohg66UyODLx7Art2zgMmBRLi-72SzaaaSxZN-4TxADjpxKsp0LgKdCURmEYvYAHVRNOSgiOkREzM932DNW9SmoBL0mjNXTl-EfbIe74kmRFGPUAN9roZ5SB-izLUJlIjXq_fV6dUrPWFhSL9ms5ahRfRao4JIkd2jUMBof6EeJFZereP_wIwCcN4TNQrOGCub0aE_9Hk-jfhhVVPbrJcVfyf4NDRR9gyBuvAtC6TSRYN7ElozgPbWsMtxPy49BVVjLcqt9QJ_4I7wQuQKpzUsjtJ8AMXwa1hykSnvhRVUVKGP8_Z0z1PX7m5vCv2du4bIXDq450pspUz_HCZUwiVDyepq07-v3-Bm7oQB9nVW9G6peBpLtQJ6iNTML7rWKv07EXq42E7EqgK4WhNt-1MAyG8pMI_C8RZpC-KJmQU=w1624-h2000-no?authuser=0'),
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
