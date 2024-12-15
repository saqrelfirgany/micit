import 'package:either_dart/either.dart';
import 'package:micit/features/home_feature/data/data_source/users_local_data_source.dart';
import 'package:micit/features/home_feature/data/models/user_model.dart';

import '../../../../core/model/failure_model.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/users_repository.dart';
import '../data_source/users_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSourceImpl remoteDataSource = UserRemoteDataSourceImpl();
  final LocalDataSource localDataSource = LocalDataSource();

  UserRepositoryImpl();

  @override
  Future<Either<FailureModel, List<UserEntity>>> fetchUsers() async {
    try {
      final response = await remoteDataSource.fetchUsers();

      return response.fold(
        (error) async {
          List<UserModel> userModelList =
              await localDataSource.getCachedUsers();
          List<UserEntity> userEntityList = userModelList.toEntityList();

          return Right(userEntityList);
        },
        (users) async {
          await localDataSource.cacheUsers(users);

          List<UserEntity> userEntityList = users.toEntityList();

          return Right(userEntityList);
        },
      );
    } catch (_) {
      List<UserModel> userModelList = await localDataSource.getCachedUsers();
      List<UserEntity> userEntityList = userModelList.toEntityList();

      return Right(userEntityList);
    }
  }

  @override
  Future<void> cacheUsers(List<UserEntity> users) async {
    List<UserModel> userModelList = users.toModelList();
    await localDataSource.cacheUsers(
      userModelList.map((e) => UserModel.fromJson(e.toJson())).toList(),
    );
  }

  @override
  Future<List<UserEntity>> getCachedUsers() async {
    List<UserModel> userModelList = await localDataSource.getCachedUsers();
    List<UserEntity> userEntityList = userModelList.toEntityList();

    return userEntityList;
  }

  @override
  Future<void> editUser(UserEntity user) async {
    final userModel = UserModel(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      avatar: user.avatar,
    );
    await localDataSource.editUser(userModel);
  }

  @override
  Future<void> addUser(UserEntity user) async {
    final userModel = UserModel(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      avatar: user.avatar,
    );
    await localDataSource.addUser(userModel);
  }

  @override
  Future<void> deleteUser(int userId) async {
    await localDataSource.deleteUser(userId);
  }

}
