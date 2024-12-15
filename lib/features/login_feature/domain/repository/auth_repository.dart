import 'package:either_dart/either.dart';

import '../../../../core/model/failure_model.dart';
import '../../data/models/user_auth_model.dart';
import '../entity/user_auth_entity.dart';



abstract class AuthRepository {
  Future<Either<FailureModel, UserAuthModel>> signInWithGoogle();
  Future<Either<FailureModel, UserAuthModel>> signInWithEmail(String email, String password);
  Future<void> logout();

}
