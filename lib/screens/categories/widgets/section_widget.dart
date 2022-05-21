import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/cubits/users/section/section_cubit.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/repositories/user_repository.dart';
import 'package:ftc_forum/screens/categories/widgets/section_item_widget.dart';
import 'package:ftc_forum/screens/sections/section_screen.dart';

class SectionWidget extends StatelessWidget {
  String sectionTitle;
  QuestionCategory category;
  SectionWidget({
    Key? key,
    required this.size,
    required this.category,
    required this.sectionTitle,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final _sectionCubit = BlocProvider.of<SectionCubit>(context);
    return Center(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _sectionCubit.fetchSectionsByCategoryId(category.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    sectionTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    height: size.height * 0.4,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        final section = Section.fromMap(doc.data(), doc.id);
                        return SectionItemWidget(
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      QuestionCubit(UserRepository()),
                                  child: SectionScreen(
                                    section: section,
                                  ),
                                ),
                              ),
                            );
                          },
                          size: size,
                          title: section.name.toString(),
                          imageUrl: section.imageUrl.toString(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
