import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/widgets/handle_bar.dart';
import 'package:ftc_forum/widgets/rounded_button.dart';

class DWriteQuestion extends StatefulWidget {
  DWriteQuestion({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<DWriteQuestion> createState() => _DWriteQuestionState();
}

class _DWriteQuestionState extends State<DWriteQuestion> {
  final quill.QuillController _controller = quill.QuillController.basic();

  List<String> items = [
    'Question',
    'Answer',
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.size.height * 0.02),
              topRight: Radius.circular(widget.size.height * 0.02),
            ),
          ),
          enableDrag: true,
          context: context,
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(vertical: widget.size.height * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // create handle bar
                HandleBar(size: widget.size),
                SizedBox(height: widget.size.height * 0.05),
                // write dropdown
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedItem,
                    isDense: true,
                    isExpanded: true,
                    hint: const Text('Choose question category'),
                    items: items.map((String items) {
                      return DropdownMenuItem<String>(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedItem = value as String?;
                      });
                    },
                  ),
                ),

                // Question Section
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Question Section",
                  ),
                ),
                // Question title
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Question Title",
                  ),
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
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: widget.size.height * 0.02,
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
        width: widget.size.width * 0.3,
        padding: EdgeInsets.all(widget.size.height * 0.005),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(widget.size.height * 0.01),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.background,
              size: widget.size.height * 0.03,
            ),
            Text(
              "Ask a question",
              style: TextStyle(color: Theme.of(context).colorScheme.background),
            ),
          ],
        ),
      ),
    );
  }
}
