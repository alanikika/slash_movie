import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

  final String label;
  final TextEditingController controller;

  const TextInput({Key? key, required this.label, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      minLines: 1,
    );
  }
}
