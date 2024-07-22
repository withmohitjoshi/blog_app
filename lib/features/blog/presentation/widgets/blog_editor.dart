import 'package:flutter/material.dart';

class BlogEditor extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const BlogEditor(
      {super.key, required this.controller, required this.hintText});

  @override
  State<BlogEditor> createState() => _BlogEditorState();
}

class _BlogEditorState extends State<BlogEditor> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      maxLines: null,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '${widget.hintText} is missing';
        }
        return null;
      },
    );
  }
}
