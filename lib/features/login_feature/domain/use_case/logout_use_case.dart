import '../../data/repository/auth_repository_impl.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository = AuthRepositoryImpl();

  LogoutUseCase();

  Future<void> call() async {
    await repository.logout();
  }
}
