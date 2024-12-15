import 'package:either_dart/either.dart';

import '../../../../core/model/failure_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/user_auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSourceImpl();

  AuthRepositoryImpl();

  @override
  Future<Either<FailureModel, UserAuthModel>> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();
      return Right(user);
    } catch (e) {
      return Left(FailureModel(message: e.toString()));
    }
  }

  @override
  Future<Either<FailureModel, UserAuthModel>> signInWithEmail(
      String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmail(email, password);
      return Right(user);
    } catch (e) {
      return Left(FailureModel(message: e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
