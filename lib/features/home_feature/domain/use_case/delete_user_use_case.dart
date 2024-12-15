import '../../data/repository/users_repository_impl.dart';
import '../repository/users_repository.dart';

class DeleteUserUseCase {
  final UserRepository repository = UserRepositoryImpl();

  DeleteUserUseCase();

  Future<void> call(int userId) async {
    return await repository.deleteUser(userId);
  }
}
