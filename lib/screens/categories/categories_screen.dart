import 'package:flutter/material.dart';
import 'package:ftc_forum/screens/categories/widgets/section_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            SectionWidget(
              size: size,
              sectionTitle: 'Web Development',
            ),
            SectionWidget(
              size: size,
              sectionTitle: 'Mobile App Development',
            ),
            SectionWidget(
              size: size,
              sectionTitle: 'Mobile App Development',
            ),
            SectionWidget(
              size: size,
              sectionTitle: 'Mobile App Development',
            ),
            SectionWidget(
              size: size,
              sectionTitle: 'Mobile App Development',
            ),
            SectionWidget(
              size: size,
              sectionTitle: 'Mobile App Development',
            ),
          ],
        ),
      ),
    );
  }
}
