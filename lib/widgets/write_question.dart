import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/cubits/users/question/question_cubit.dart';
import 'package:ftc_forum/models/question.dart';

import 'package:ftc_forum/widgets/rounded_button.dart';

class WriteQuestion extends StatefulWidget {
  WriteQuestion({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<WriteQuestion> createState() => _WriteQuestionState();
}

class _WriteQuestionState extends State<WriteQuestion> {
  final quill.QuillController _controller = quill.QuillController.basic();

  List<String> items = [
    'Question',
    'Answer',
  ];

  dynamic selectedCategoryItem;
  dynamic selectedSectionItem;

  @override
  Widget build(BuildContext context) {
    final _appBloc = BlocProvider.of<AppBloc>(context);
    final _questionCubit = BlocProvider.of<QuestionCubit>(context);
    _questionCubit.uidChanged(_appBloc.state.user.id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Write Question'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: widget.size.height * 0.01),
        child: BlocListener<QuestionCubit, QuestionState>(
          listener: (context, screenState) {
            // TODO: implement listener
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: widget.size.height * 0.05),
                // write dropdown
                DropdownButtonHideUnderline(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: context.read<QuestionCubit>().fetchCategories(),
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
                        value: selectedCategoryItem,
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
                          setState(
                            () {
                              selectedCategoryItem = value;
                              context
                                  .read<QuestionCubit>()
                                  .selectedCategoryIdChanged(value);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                // write dropdown
                context.read<QuestionCubit>().state.status ==
                        QuestionStatus.success
                    ? DropdownButtonHideUnderline(
                        child: Container(
                          margin:
                              EdgeInsets.only(top: widget.size.height * 0.02),
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: context
                                .read<QuestionCubit>()
                                .fetchSectionsByCategoryId(),
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
                              return BlocBuilder<QuestionCubit, QuestionState>(
                                buildWhen: (previous, current) =>
                                    previous.selectedCategoryId !=
                                    current.selectedCategoryId,
                                builder: (context, state) {
                                  return DropdownButton<dynamic>(
                                    key: Key(state.selectedSectionId),
                                    value: selectedSectionItem,
                                    isDense: true,
                                    isExpanded: true,
                                    hint: const Text('Choose Section'),
                                    items: snapshot.data!.docs.map((doc) {
                                      return DropdownMenuItem<dynamic>(
                                        value: doc.id,
                                        child: Text(doc.data()['sectionName']),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSectionItem = value;
                                        context
                                            .read<QuestionCubit>()
                                            .selectedSectionIdChanged(value);
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    : Container(),

                // Question title
                BlocBuilder<QuestionCubit, QuestionState>(
                  buildWhen: (previous, current) =>
                      previous.title != current.title,
                  builder: (context, state) {
                    return TextFormField(
                      onChanged: ((value) =>
                          context.read<QuestionCubit>().titleChanged(value)),
                      decoration: const InputDecoration(
                        labelText: "Question Title",
                      ),
                    );
                  },
                ),
                // create quill editor
                ListTile(
                  leading: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: widget.size.height * 0.018,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                quill.QuillToolbar.basic(controller: _controller),
                BlocBuilder<QuestionCubit, QuestionState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context.read<QuestionCubit>().uploadImage(context);
                      },
                      child: SizedBox(
                        height: widget.size.height * 0.05,
                        child: state.status == QuestionStatus.loading
                            ? const CircularProgressIndicator()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Upload Image"),
                                  Icon(Icons.upload_file),
                                ],
                              ),
                      ),
                    );
                  },
                ),
                Container(
                  height: widget.size.height * 0.3,
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    top: widget.size.height * 0.02,
                  ),
                  child: quill.QuillEditor.basic(
                    controller: _controller,
                    readOnly: false, // true for view only mode
                  ),
                ),

                BlocBuilder<QuestionCubit, QuestionState>(
                  builder: (context, state) {
                    return state.status == QuestionStatus.loading
                        ? const CircularProgressIndicator()
                        : RoundedButton(
                            text: "Post",
                            press: () {
                              var json = jsonEncode(
                                  _controller.document.toDelta().toJson());
                              context
                                  .read<QuestionCubit>()
                                  .descriptionChanged(json);
                              context.read<QuestionCubit>().postQuestion(context);
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
