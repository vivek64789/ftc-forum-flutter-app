import 'package:flutter/material.dart';
import 'package:ftc_forum/constants.dart';
import 'package:ftc_forum/widgets/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
              onPressed: () => togglePasswordVisibility(),
              color: kPrimaryColor,
              splashRadius: 30,
              icon: _obscureText
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
