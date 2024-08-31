import 'package:flutter/material.dart';
import '../../constant.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    this.obscureText = false,
  }) : super(key: key);

  final String text;
  final bool obscureText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val!.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(space * 7),
        ),
      ),
    );
  }
}
