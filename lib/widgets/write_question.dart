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
  final String qid;
  final String uid;
  final String categoryId;
  final String sectionId;
  final String? title;
  final String? imageUrl;
  final dynamic description;
  final bool isInit;
  WriteQuestion({
    Key? key,
    required this.qid,
    required this.uid,
    required this.categoryId,
    required this.sectionId,
    this.title = "",
    this.imageUrl = "",
    this.description,
    this.isInit = false,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<WriteQuestion> createState() => _WriteQuestionState();
}

class _WriteQuestionState extends State<WriteQuestion> {
  quill.QuillController _controller = quill.QuillController.basic();

  List<String> items = [
    'Question',
    'Answer',
  ];
  dynamic selectedCategoryItem;
  dynamic selectedSectionItem;
  List<String> a = [];

  @override
  void initState() {
    if (widget.isInit) {
      selectedCategoryItem =
          widget.categoryId.isEmpty ? null : widget.categoryId;
      selectedSectionItem = widget.sectionId.isEmpty ? null : widget.sectionId;
      context
          .read<QuestionCubit>()
          .selectedCategoryIdChanged(selectedCategoryItem);
      context
          .read<QuestionCubit>()
          .selectedSectionIdChanged(selectedSectionItem);
      if (widget.title!.isNotEmpty) {
        context.read<QuestionCubit>().titleChanged(widget.title.toString());
      }
      if (widget.imageUrl!.isNotEmpty) {
        context
            .read<QuestionCubit>()
            .imageUrlChanged(widget.imageUrl.toString());
      }

      if (widget.description == null) {
      } else {
        _controller = quill.QuillController(
          document: quill.Document.fromJson(widget.description),
          selection: const TextSelection.collapsed(offset: 0),
        );
      }
    }
    super.initState();
  }

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

                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(widget.size.height * 0.01),
                        ),
                        child: DropdownButton<dynamic>(
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
                                selectedSectionItem = null;
                                context
                                    .read<QuestionCubit>()
                                    .selectedCategoryIdChanged(value);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                // write dropdown
                context.read<QuestionCubit>().state.status ==
                        QuestionStatus.success
                    ? DropdownButtonHideUnderline(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                widget.size.height * 0.01),
                          ),
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
                                    previous.selectedSectionId !=
                                    current.selectedSectionId,
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
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(widget.size.height * 0.01),
                      ),
                      child: TextFormField(
                        initialValue: widget.title,
                        onChanged: ((value) =>
                            context.read<QuestionCubit>().titleChanged(value)),
                        decoration: const InputDecoration(
                          labelText: "Question Title",
                        ),
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

                widget.qid.isEmpty
                    ? BlocBuilder<QuestionCubit, QuestionState>(
                        builder: (context, state) {
                          return state.status == QuestionStatus.loading
                              ? const CircularProgressIndicator()
                              : RoundedButton(
                                  text: "Post",
                                  press: () {
                                    var json = jsonEncode(_controller.document
                                        .toDelta()
                                        .toJson());
                                    context
                                        .read<QuestionCubit>()
                                        .descriptionChanged(json);
                                    context
                                        .read<QuestionCubit>()
                                        .postQuestion(context);
                                  },
                                );
                        },
                      )
                    : BlocBuilder<QuestionCubit, QuestionState>(
                        builder: (context, state) {
                          return state.status == QuestionStatus.loading
                              ? const CircularProgressIndicator()
                              : RoundedButton(
                                  text: "Update Post",
                                  press: () {
                                    var json = jsonEncode(_controller.document
                                        .toDelta()
                                        .toJson());
                                    context
                                        .read<QuestionCubit>()
                                        .descriptionChanged(json);
                                    context
                                        .read<QuestionCubit>()
                                        .updatePostQuestion(
                                            context, widget.qid);
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
