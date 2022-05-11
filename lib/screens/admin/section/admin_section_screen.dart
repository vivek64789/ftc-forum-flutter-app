import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/admin/category/category_cubit.dart';
import 'package:ftc_forum/cubits/admin/section/section_cubit.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/repositories/admin_repository.dart';
import 'package:ftc_forum/screens/admin/category/add_new_category_screen.dart';
import 'package:ftc_forum/screens/admin/section/add_new_section_screen.dart';

class AdminSectionScreen extends StatelessWidget {
  AdminSectionScreen({Key? key}) : super(key: key);

  List<Section> dummyCategories = [
    const Section(
      id: "1",
      name: "Category 1",
      category: QuestionCategory(id: "id1", name: "Category 1"),
      imageUrl: "",
    ),
    const Section(
      id: "2",
      name: "Category 2",
      category: QuestionCategory(id: "id1", name: "Category 1"),
      imageUrl: "",
    ),
    const Section(
      id: "3",
      name: "Category 3",
      category: QuestionCategory(id: "id1", name: "Category 1"),
      imageUrl: "",
    ),
    const Section(
      id: "4",
      name: "Category 4",
      category: QuestionCategory(id: "id1", name: "Category 1"),
      imageUrl: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Sections'),
        centerTitle: true,
      ),
      body: BlocListener<SectionCubit, SectionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: context.read<SectionCubit>().fetchSections(),
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

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      snapshot.data!.docs[index].data()["sectionName"],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        SectionCubit(AdminRepository()),
                                    child: AddNewCategoryScreen(
                                      initialCategory: QuestionCategory(
                                        id: snapshot.data!.docs[index].id,
                                        name: snapshot.data!.docs[index]
                                            .data()["sectionName"],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        context.read<SectionCubit>().state.status ==
                                SectionStatus.loading
                            ? const CircularProgressIndicator()
                            : IconButton(
                                onPressed: () {
                                  context.read<SectionCubit>().deleteSection(
                                      snapshot.data!.docs[index].id, context);
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => SectionCubit(
                        AdminRepository(),
                      ),
                    ),
                    BlocProvider(
                      create: (_) => CategoryCubit(
                        AdminRepository(),
                      ),
                    ),
                  ],
                  child: AddNewSectionScreen(),
                );
              },
            ),
          );
        },
        color: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
