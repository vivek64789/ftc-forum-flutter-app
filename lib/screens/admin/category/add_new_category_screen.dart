import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/admin/category/admin_category_cubit.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';
import 'package:ftc_forum/widgets/rounded_input_field.dart';

class AddNewCategoryScreen extends StatelessWidget {
  final QuestionCategory? initialCategory;
  const AddNewCategoryScreen({Key? key, this.initialCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: initialCategory != null
            ? const Text("Update Category")
            : const Text('Add New Category'),
        centerTitle: true,
      ),
      body: BlocListener<AdminCategoryCubit, AdminCategoryState>(
        listener: (context, state) {
          if (state.status == CategoryStatus.initial) ;
        },
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AdminCategoryCubit, AdminCategoryState>(
                buildWhen: (previous, current) =>
                    previous.categoryName != current.categoryName,
                builder: (context, state) {
                  return RoundedInputField(
                    initialValue: initialCategory?.categoryName,
                    hintText: "Enter Category Name",
                    onChanged: (value) {
                      context
                          .read<AdminCategoryCubit>()
                          .categoryNameChanged(value);
                    },
                    icon: Icons.category,
                  );
                },
              ),
              BlocBuilder<AdminCategoryCubit, AdminCategoryState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return state.status == CategoryStatus.loading
                      ? const CircularProgressIndicator()
                      : RoundedButton(
                          text: initialCategory != null ? "Update" : "Save",
                          press: () {
                            initialCategory != null
                                ? context
                                    .read<AdminCategoryCubit>()
                                    .updateCategory(
                                        initialCategory!.id, context)
                                : context
                                    .read<AdminCategoryCubit>()
                                    .addCategory(context);
                          },
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
