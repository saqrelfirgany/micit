import '../../data/repository/users_repository_impl.dart';
import '../entity/user_entity.dart';
import '../repository/users_repository.dart';

class EditUserUseCase {
  final UserRepository repository = UserRepositoryImpl();

  EditUserUseCase();

  Future<void> call(UserEntity user) async {
    return await repository.editUser(user);
  }
}
