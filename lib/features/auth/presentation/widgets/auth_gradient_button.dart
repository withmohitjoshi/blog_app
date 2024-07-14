import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatefulWidget {
  final void Function()? onPressed;
  final String text;
  const AuthGradientButton({super.key, this.onPressed, required this.text});

  @override
  State<AuthGradientButton> createState() => _AuthGradientButtonState();
}

class _AuthGradientButtonState extends State<AuthGradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [AppPallete.gradient1, AppPallete.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(
          7,
        ),
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 55),
          shadowColor: AppPallete.transparentColor,
          backgroundColor: AppPallete.transparentColor,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            color: AppPallete.whiteColor,
          ),
        ),
      ),
    );
  }
}
