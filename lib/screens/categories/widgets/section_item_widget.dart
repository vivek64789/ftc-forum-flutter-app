import 'package:flutter/material.dart';

class SectionItemWidget extends StatelessWidget {
  String title;
  String imageUrl;
  Function onPress;
  SectionItemWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.size,
    required this.onPress,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        splashColor: Colors.red,
        radius: 20,
        onTap: () => onPress(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: size.height * 0.05,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    size.width * 0.015,
                  ),
                  child: Image.network(
                    imageUrl,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              // width: size.width * 0.25,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
