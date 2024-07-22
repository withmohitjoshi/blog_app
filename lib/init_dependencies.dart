import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/app_secret.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    anonKey: AppSecret.supabaseKey!,
    url: AppSecret.supabaseUrl!,
  );
  Hive.init((await getApplicationDocumentsDirectory()).path);
  final box = await Hive.openBox('blogs');
  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerLazySingleton(() => box);

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(internetConnection: serviceLocator()));
}

void _initAuth() {
  serviceLocator
    // data source (here we create function which deal with the supabase in real and give raw data model and model extends the entities)
    ..registerFactory<AuthRemoteDataSource>(() {
      return AuthRemoteDataSourceImpl(supabaseClient: serviceLocator());
    })
    // repository (utilies the data resource function and get success or error and handles them)
    ..registerFactory<AuthRepository>(() {
      return AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      );
    })
    // (usecase) is a single responsibility class which use repository function (which in turn use data source fn) and gives us the entity
    ..registerFactory(() {
      return UserSignUp(authRepository: serviceLocator());
    })
    ..registerFactory(() {
      return UserLogin(authRepository: serviceLocator());
    })
    ..registerFactory(() {
      return CurrentUser(authRepository: serviceLocator());
    })
    // bloc deals with the State of our application
    ..registerLazySingleton(() {
      return AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      );
    });
}

void _initBlog() {
  serviceLocator
    // data source (here we create function which deal with the supabase in real and give raw data model and model extends the entities)
    ..registerFactory<BlogRemoteDataSource>(() {
      return BlogRemoteDataSourceImpl(supabaseClient: serviceLocator());
    })
    ..registerFactory<BlogLocalDataSource>(() {
      return BlogLocalDataSourceImpl(box: serviceLocator());
    })
    // repository (utilies the data resource function and get success or error and handles them)
    ..registerFactory<BlogRepository>(() {
      return BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
      );
    })
    // (usecase) is a single responsibility class which use repository function (which in turn use data source fn) and gives us the entity
    ..registerFactory(() {
      return UploadBlog(blogRepository: serviceLocator());
    })
    ..registerFactory(() {
      return GetAllBlogs(blogRepository: serviceLocator());
    })
    // bloc deals with the State of our application
    ..registerLazySingleton(() {
      return BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      );
    });
}
