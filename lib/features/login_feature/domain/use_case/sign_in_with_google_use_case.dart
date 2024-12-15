import 'package:either_dart/either.dart';

import '../../../../core/model/failure_model.dart';
import '../../data/models/user_auth_model.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../repository/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository = AuthRepositoryImpl();

  SignInWithGoogle();

  Future<Either<FailureModel, UserAuthModel>> call() {
    return repository.signInWithGoogle();
  }
}
