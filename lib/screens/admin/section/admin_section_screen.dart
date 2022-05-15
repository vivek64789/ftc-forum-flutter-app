import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/admin/category/admin_category_cubit.dart';
import 'package:ftc_forum/cubits/admin/section/admin_section_cubit.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/repositories/admin_repository.dart';
import 'package:ftc_forum/screens/admin/category/add_new_category_screen.dart';
import 'package:ftc_forum/screens/admin/section/add_new_section_screen.dart';

class AdminSectionScreen extends StatelessWidget {
  AdminSectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminSectionCubit _adminSectionCubit =
        BlocProvider.of<AdminSectionCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Sections'),
        centerTitle: true,
      ),
      body: BlocListener<AdminSectionCubit, AdminSectionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: context.read<AdminSectionCubit>().fetchSections(),
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
                                        AdminSectionCubit(AdminRepository()),
                                    child: BlocProvider(
                                      create: (_) =>
                                          AdminCategoryCubit(AdminRepository()),
                                      child: AddNewSectionScreen(
                                        initialSection: Section(
                                          id: snapshot.data!.docs[index].id,
                                          name: snapshot.data!.docs[index]
                                              .data()["sectionName"],
                                          category: snapshot.data!.docs[index]
                                              .data()["categoryId"],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        context.read<AdminSectionCubit>().state.status ==
                                SectionStatus.loading
                            ? const CircularProgressIndicator()
                            : IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Delete Question"),
                                        content: const Text(
                                            "Are you sure you want to delete this question?"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Delete"),
                                            onPressed: () {
                                              _adminSectionCubit.deleteSection(
                                                  snapshot.data!.docs[index].id,
                                                  context);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
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
                      create: (_) => AdminSectionCubit(
                        AdminRepository(),
                      ),
                    ),
                    BlocProvider(
                      create: (_) => AdminCategoryCubit(
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
