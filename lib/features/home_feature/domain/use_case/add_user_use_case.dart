import '../../data/repository/users_repository_impl.dart';
import '../entity/user_entity.dart';
import '../repository/users_repository.dart';

class AddUserUseCase {
  final UserRepository repository = UserRepositoryImpl();

  AddUserUseCase();

  Future<void> call(UserEntity user) async {
    return await repository.addUser(user);
  }
}
