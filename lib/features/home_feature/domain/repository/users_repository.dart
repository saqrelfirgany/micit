import 'package:either_dart/either.dart';

import '../../../../core/model/failure_model.dart';
import '../entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<FailureModel, List<UserEntity>>> fetchUsers();
  Future<void> cacheUsers(List<UserEntity> users);
  Future<List<UserEntity>> getCachedUsers();
}