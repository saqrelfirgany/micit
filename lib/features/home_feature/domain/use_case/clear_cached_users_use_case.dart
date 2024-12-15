import '../../data/repository/users_repository_impl.dart';
import '../repository/users_repository.dart';

class ClearCachedUsersUseCase {
  final UserRepository repository = UserRepositoryImpl();

  ClearCachedUsersUseCase();

  Future<void> call() async {
    await repository.clearCachedUsers();
  }
}
