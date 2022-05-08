import 'package:flutter/material.dart';

class HandleBar extends StatelessWidget {
  const HandleBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.008,
      width: size.width * 0.1,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(size.height * 0.02),
      ),
    );
  }
}
