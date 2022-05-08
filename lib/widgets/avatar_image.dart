import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  String profileUrl;
  double height;

  AvatarImage({
    Key? key,
    required this.profileUrl,
    this.height = 100,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipOval(
        child: Image.network(
          profileUrl,
          height: height,
        ),
      ),
    );
  }
}
