import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final bool obscureText; // Initial visibility state
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextEditingController controller;

  const AuthField({
    super.key,
    this.obscureText = false,
    required this.hintText,
    this.textInputType = TextInputType.name,
    this.validator,
    required this.controller,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _showPassword ? false : widget.obscureText,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              )
            : null,
      ),
      validator: widget.validator ??
          (value) {
            if (value!.isEmpty) {
              return '${widget.hintText} is missing!';
            }
            return null;
          },
      controller: widget.controller,
    );
  }
}
