import 'package:blog_app/core/secrets/app_secret.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    anonKey: AppSecret.supabaseKey!,
    url: AppSecret.supabaseUrl!,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(() {
    return AuthRemoteDataSourceImpl(supabaseClient: serviceLocator());
  });

  serviceLocator.registerFactory<AuthRepository>(() {
    return AuthRepositoryImpl(remoteDataSource: serviceLocator());
  });

  serviceLocator.registerFactory(() {
    return UserSignUp(authRepository: serviceLocator());
  });

  serviceLocator.registerFactory(() {
    return UserLogin(authRepository: serviceLocator());
  });

  serviceLocator.registerLazySingleton(() {
    return AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
    );
  });
}
