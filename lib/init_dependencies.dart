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
  serviceLocator
    // data source (here we create function which deal with the supabase in real and give raw data model and model extends the entities)
    ..registerFactory<AuthRemoteDataSource>(() {
      return AuthRemoteDataSourceImpl(supabaseClient: serviceLocator());
    })
    // repository (utilies the data resource function and get success or error and handles them)
    ..registerFactory<AuthRepository>(() {
      return AuthRepositoryImpl(remoteDataSource: serviceLocator());
    })
    // (usecase) is a single responsibility class which use repository function (which in turn use data source fn) and gives us the entity
    ..registerFactory(() {
      return UserSignUp(authRepository: serviceLocator());
    })
    ..registerFactory(() {
      return UserLogin(authRepository: serviceLocator());
    })
    // bloc deals with the State of our application
    ..registerLazySingleton(() {
      return AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      );
    });
}
