import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.connectionChecker});

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return await _getUser(() async => await remoteDataSource
        .loginWithEmailPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signupWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return await _getUser(() async => await remoteDataSource
        .signupWithEmailPassword(name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure('No Internt connection'));
      }
      final User user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged In!'));
        }
        return right(UserModel(
            id: session.user.id, email: session.user.email ?? '', name: ''));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user != null) {
        return right(user);
      } else {
        return left(Failure('User not logged In!'));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
