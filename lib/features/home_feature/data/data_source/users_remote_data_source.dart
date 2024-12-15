import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/helper/dio_helper.dart';
import '../../../../core/helper/endpoint/endpoints_helper.dart';
import '../../../../core/model/failure_model.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Either<FailureModel, List<UserModel>>> fetchUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
      GoogleSignIn(forceCodeForRefreshToken: true);

  UserRemoteDataSourceImpl();

  @override
  Future<Either<FailureModel, List<UserModel>>> fetchUsers() async {
    final response = await DioHelper.get(
      url: EndpointHelper.usersEndpoint,
    );
    try {
      return response.fold(
        (error) {
          return Left(
            FailureModel(
              message: error.message,
              statusCode: error.statusCode,
              errors: error.errors,
            ),
          );
        },
        (response) {
          if (response != null) {
            final List<dynamic> dynamicList = response['data'];
            List<UserModel> userList = [];

            for (var element in dynamicList) {
              userList.add(UserModel.fromJson(element));
            }

            return Right(userList);
          } else {
            return Left(
              FailureModel(
                message: 'Failed to fetch users',
              ),
            );
          }
        },
      );
    } catch (e) {
      return Left(
        FailureModel(
          message: 'Failed to fetch users',
        ),
      );
    }
  }
}
