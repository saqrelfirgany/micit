import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:micit/core/helper/helper.dart';
import 'package:micit/features/login_feature/domain/use_case/sign_in_with_google_use_case.dart';

import '../../data/models/user_model.dart';
import '../../domain/use_case/logout_use_case.dart';

part 'login_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogle signInWithGoogleUseCase = SignInWithGoogle();
  final LogoutUseCase logoutUseCase = LogoutUseCase();

  AuthCubit() : super(AuthInitial());

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await signInWithGoogleUseCase();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        Helper.saveUserModel(userModel: user);
        Helper.saveUserLogged(true);
        Helper.isLoggedIn = true;
        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> getUser() async {
    final response = await Helper.getUserModel();
    if (response != null) {
      final UserModel userModel = response;
    }
  }

  Future<void> logout() async {
    final result = await logoutUseCase();
    Helper.removeUserModel();
  }
}
