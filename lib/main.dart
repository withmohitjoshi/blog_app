import 'package:blog_app/core/secrets/app_secret.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final supabase = await Supabase.initialize(
    anonKey: AppSecret.supabaseKey!,
    url: AppSecret.supabaseUrl!,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          userSignUp: UserSignUp(
            authRepository: AuthRepositoryImpl(
              remoteDataSource:
                  AuthRemoteDataSourceImpl(supabaseClient: supabase.client),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
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
