import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const TextInputWidget({
    Key? key,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20), gapPadding: 8),
        hintText: hintText,
        filled: true,
        fillColor: Colors.blueGrey,
      ),
    );
  }
}
