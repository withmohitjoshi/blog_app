import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              AuthField(
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                controller: _emailController, // Associate with controller
              ),
              SizedBox(height: 20),
              AuthField(
                obscureText: true,
                hintText: "Password",
                textInputType: TextInputType.visiblePassword,
                controller: _passwordController, // Associate with controller
              ),
              SizedBox(height: 20),
              AuthGradientButton(
                text: 'Sign up',
                onPressed: () {},
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SignupPage.routeName);
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account  ? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "SignIn",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
