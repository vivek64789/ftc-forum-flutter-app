import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/cubits/users/reply/reply_cubit.dart';
import 'package:ftc_forum/widgets/handle_bar.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';

class WriteComment extends StatelessWidget {
  final String qid;
  final String? id;
  final List<dynamic>? description;
  final bool? isInit;
  WriteComment(
      {Key? key,
      required this.qid,
      required this.size,
      this.id,
      this.description,
      this.isInit})
      : super(key: key);

  final Size size;
  final quill.QuillController _controller = quill.QuillController.basic();
  @override
  Widget build(BuildContext context) {
    final _replyCubit = BlocProvider.of<ReplyCubit>(context);
    final _appBloc = BlocProvider.of<AppBloc>(context);

    _replyCubit.qidChanged(qid);
    _replyCubit.uidChanged(_appBloc.state.user.id);
    return BlocListener<ReplyCubit, ReplyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: GestureDetector(
        onTap: () {
          showBottomSheet(
            context: context,
            builder: (_) => Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // create handle bar
                  HandleBar(size: size),

                  // create quill editor
                  quill.QuillToolbar.basic(controller: _controller),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: quill.QuillEditor.basic(
                        controller: _controller,
                        readOnly: false, // true for view only mode
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "Post",
                    press: () {
                      var json =
                          jsonEncode(_controller.document.toDelta().toJson());
                      context.read<ReplyCubit>().descriptionChanged(json);
                      context.read<ReplyCubit>().postReply(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: size.height * 0.05,
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.01,
          ),
          padding: EdgeInsets.symmetric(
              vertical: size.width * 0.03, horizontal: size.width * 0.03),
          child: Text(
            "Write your comment here...",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(size.height * 0.01),
          ),
        ),
      ),
    );
  }
}
