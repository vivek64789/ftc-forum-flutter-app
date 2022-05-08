import 'package:flutter/material.dart';

class VoteButton extends StatefulWidget {
  final IconData icon;
  final Function onPress;
  bool isSelected;
  VoteButton({
    Key? key,
    required this.icon,
    required this.onPress,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IconButton(
      color: widget.isSelected
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      splashColor: Theme.of(context).primaryColor,
      onPressed: () {
        widget.onPress();
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      icon: Icon(
        widget.icon,
        size: size.width * 0.04,
      ),
    );
  }
}
