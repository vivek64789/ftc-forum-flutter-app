import 'package:flutter/material.dart';
import 'package:ftc_forum/screens/categories/categories_screen.dart';
import 'package:ftc_forum/screens/categories/widgets/section_item_widget.dart';
import 'package:ftc_forum/screens/sections/section_screen.dart';

class SectionWidget extends StatelessWidget {
  String sectionTitle;
  SectionWidget({
    Key? key,
    required this.size,
    required this.sectionTitle,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.02),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            sectionTitle,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SectionItemWidget(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SectionScreen(),
                      ),
                    );
                  },
                  size: size,
                  title: "Flutter",
                  imageUrl:
                      "https://cdn.dribbble.com/users/1622791/screenshots/11174104/flutter_intro.png",
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
