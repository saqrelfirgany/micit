import 'package:either_dart/src/either.dart';
import 'package:micit/core/model/failure_model.dart';

import '../../data/repository/users_repository_impl.dart';
import '../entity/user_entity.dart';
import '../repository/users_repository.dart';

class FetchUsersUseCase {
  final UserRepository repository = UserRepositoryImpl();

  FetchUsersUseCase();

  Future<Either<FailureModel, List<UserEntity>>> call() async {
    return await repository.fetchUsers();
  }
}
