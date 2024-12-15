import 'package:either_dart/either.dart';

import '../../../../core/model/failure_model.dart';
import '../../data/models/user_model.dart';
import '../entity/user_entity.dart';



abstract class AuthRepository {
  Future<Either<FailureModel, UserModel>> signInWithGoogle();
  Future<Either<FailureModel, UserModel>> signInWithEmail(String email, String password);
  Future<void> logout();

}
