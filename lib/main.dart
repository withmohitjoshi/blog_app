import 'package:blog_app/core/secrets/app_secret.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  if (AppSecret.supabaseKey != null && AppSecret.supabaseUrl != null) {
    await Supabase.initialize(
      anonKey: AppSecret.supabaseKey!,
      url: AppSecret.supabaseUrl!,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignupPage.routeName: (context) => SignupPage(),
      },
      initialRoute: LoginPage.routeName,
      home: const LoginPage(),
    );
  }
}
