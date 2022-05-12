import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ftc_forum/main.dart';
import 'package:ftc_forum/widgets/handle_bar.dart';
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

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Write Question'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: widget.size.height * 0.01),
        child: ListView(
          children: [
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
            // write dropdown
            DropdownButtonHideUnderline(
              child: Container(
                margin: EdgeInsets.only(top: widget.size.height * 0.02),
                child: DropdownButton(
                  value: selectedItem,
                  isDense: true,
                  isExpanded: true,
                  hint: const Text('Choose Section'),
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
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: widget.size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Upload Image"),
                    Icon(Icons.upload_file),
                  ],
                ),
              ),
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

            RoundedButton(
              text: "Post",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
