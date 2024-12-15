import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:micit/features/home_feature/domain/use_case/add_user_use_case.dart';
import 'package:micit/features/home_feature/domain/use_case/delete_user_use_case.dart';
import 'package:micit/features/home_feature/domain/use_case/edit_user_use_case.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/use_case/clear_cached_users_use_case.dart';
import '../../domain/use_case/fetch_users_use_case.dart';
import '../../domain/use_case/get_cached_users_use_case.dart';

part 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    fetchUsers();
  }

  final FetchUsersUseCase fetchUsersUseCase = FetchUsersUseCase();
  final GetCachedUsersUseCase getCachedUsersUseCase = GetCachedUsersUseCase();
  final EditUserUseCase editUserUseCase = EditUserUseCase();
  final AddUserUseCase addUserUseCase = AddUserUseCase();
  final DeleteUserUseCase deleteUserUseCase = DeleteUserUseCase();
  final ClearCachedUsersUseCase clearCachedUsersUseCase =
      ClearCachedUsersUseCase();

  Future<bool> syncData() async {
    try {
      emit(HomeLoading());
      await clearCachedUsersUseCase();

      // Fetch fresh users from API
      final response = await fetchUsersUseCase.call();
      response.fold(
        (left) {
          emit(HomeError(left.message));
        },
        (users) async {
          // Clear local SQLite data

          // Insert fresh users into SQLite
          for (final user in users) {
            await addUserUseCase(user);
          }

          // Emit updated state
          emit(HomeLoaded(users: users));
        },
      );
      return true;
    } catch (e) {
      log('Error during syncData: $e');
      emit(HomeError('Failed to synchronize data.'));
      return false;
    }
  }

  Future<void> fetchUsers() async {
    emit(HomeLoading());
    try {
      final response = await fetchUsersUseCase.call();
      response.fold(
        (left) {
          emit(HomeError(left.message));
        },
        (users) {
          emit(HomeLoaded(users: users));
        },
      );
    } catch (e) {
      emit(HomeError('Failed to fetch users'));
    }
  }

  Future<void> getCachedUsers() async {
    emit(HomeLoading());
    try {
      final response = await getCachedUsersUseCase.call();
      emit(HomeLoaded(users: response));
    } catch (e) {
      emit(HomeError('Failed to fetch users'));
    }
  }

  void editUser({required UserEntity user}) async {
    await editUserUseCase(user);
    await getCachedUsers();
  }

  void addUser({required UserEntity user}) async {
    await addUserUseCase(user);
    await getCachedUsers();
  }

  void deleteUser({required int userId}) async {
    await deleteUserUseCase(userId);
    await getCachedUsers();
  }
}
