import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/widgets/handle_bar.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';

class WriteComment extends StatelessWidget {
  WriteComment({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  final quill.QuillController _controller = quill.QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * 0.02),
              topRight: Radius.circular(size.height * 0.02),
            ),
          ),
          enableDrag: true,
          context: context,
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  press: () {},
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
    );
  }
}
