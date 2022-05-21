import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftc_forum/cubits/admin/category/admin_category_cubit.dart';
import 'package:ftc_forum/cubits/admin/section/admin_section_cubit.dart';
import 'package:ftc_forum/models/question_category.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';
import 'package:ftc_forum/widgets/rounded_input_field.dart';

class AddNewSectionScreen extends StatefulWidget {
  final Section? initialSection;
  AddNewSectionScreen({Key? key, this.initialSection}) : super(key: key);

  @override
  State<AddNewSectionScreen> createState() => _AddNewSectionScreenState();
}

class _AddNewSectionScreenState extends State<AddNewSectionScreen> {
  List<dynamic> items = [
    'Question',
    'Answer',
  ];

  dynamic? selectedItem;

  @override
  Widget build(BuildContext context) {
    final _adminSectionCubit = BlocProvider.of<AdminSectionCubit>(context);
    final categoryCubit = BlocProvider.of<AdminCategoryCubit>(context);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: widget.initialSection != null
            ? const Text("Update Section")
            : const Text('Add New Section'),
        centerTitle: true,
      ),
      body: BlocListener<AdminSectionCubit, AdminSectionState>(
        listener: (context, state) {
          if (state.status == CategoryStatus.initial) ;
        },
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: DropdownButtonHideUnderline(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: categoryCubit.fetchCategories(),
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

                        return DropdownButton<dynamic>(
                          value: selectedItem,
                          isDense: true,
                          isExpanded: true,
                          hint: const Text('Choose question category'),
                          items: snapshot.data!.docs.map((doc) {
                            return DropdownMenuItem<dynamic>(
                              value: doc.id,
                              child: Text(doc.data()['categoryName']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value;
                            });
                            _adminSectionCubit.categoryChanged(
                              category: QuestionCategory(
                                id: value,
                                categoryName: snapshot.data!.docs
                                    .firstWhere((doc) => doc.id == value)
                                    .data()['categoryName'],
                              ),
                            );
                          },
                        );
                      }),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              BlocBuilder<AdminSectionCubit, AdminSectionState>(
                buildWhen: (previous, current) =>
                    previous.sectionName != current.sectionName,
                builder: (context, state) {
                  return RoundedInputField(
                    initialValue: widget.initialSection?.name,
                    hintText: "Enter Section Name",
                    onChanged: (value) {
                      context.read<AdminSectionCubit>().sectionNameChanged(
                            sectionName: value,
                          );
                    },
                    icon: Icons.category,
                  );
                },
              ),
              BlocBuilder<AdminSectionCubit, AdminSectionState>(
                buildWhen: (previous, current) =>
                    previous.sectionName != current.sectionName,
                builder: (context, state) {
                  return state.status == SectionStatus.loading
                      ? const CircularProgressIndicator()
                      : IconButton(
                          onPressed: () {
                            _adminSectionCubit.uploadImage(context);
                          },
                          icon: const Icon(Icons.upload));
                },
              ),
              BlocBuilder<AdminSectionCubit, AdminSectionState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return state.status == SectionStatus.loading
                      ? const CircularProgressIndicator()
                      : RoundedButton(
                          text:
                              widget.initialSection != null ? "Update" : "Save",
                          press: () {
                            widget.initialSection != null
                                ? context
                                    .read<AdminSectionCubit>()
                                    .updateSection(
                                        widget.initialSection!.id, context)
                                : context
                                    .read<AdminSectionCubit>()
                                    .addSection(context);
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
