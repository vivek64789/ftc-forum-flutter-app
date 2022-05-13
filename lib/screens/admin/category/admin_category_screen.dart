import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/admin/category/admin_category_cubit.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/repositories/admin_repository.dart';
import 'package:ftc_forum/screens/admin/category/add_new_category_screen.dart';

class AdminCategoryScreen extends StatelessWidget {
  AdminCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Category'),
        centerTitle: true,
      ),
      body: BlocListener<AdminCategoryCubit, AdminCategoryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: context.read<AdminCategoryCubit>().fetchCategories(),
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
                      snapshot.data!.docs[index].data()["categoryName"],
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
                                        AdminCategoryCubit(AdminRepository()),
                                    child: AddNewCategoryScreen(
                                      initialCategory: QuestionCategory(
                                        id: snapshot.data!.docs[index].id,
                                        categoryName: snapshot.data!.docs[index]
                                            .data()["categoryName"],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        context.read<AdminCategoryCubit>().state.status ==
                                CategoryStatus.loading
                            ? const CircularProgressIndicator()
                            : IconButton(
                                onPressed: () {
                                  context
                                      .read<AdminCategoryCubit>()
                                      .deleteCategory(
                                          snapshot.data!.docs[index].id,
                                          context);
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
                return BlocProvider(
                  create: (_) => AdminCategoryCubit(
                    AdminRepository(),
                  ),
                  child: AddNewCategoryScreen(),
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
