import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/use_case/fetch_users_use_case.dart';

part 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    fetchUsers();
  }

  final FetchUsersUseCase fetchUsersUseCase = FetchUsersUseCase();

  Future<void> fetchUsers() async {
    emit(HomeLoading());
    try {
      final response = await fetchUsersUseCase.call();
      response.fold(
        (left) {
          emit(HomeError(left.message));
        },
        (users) {
          emit(HomeLoaded(users));
        },
      );
    } catch (e) {
      emit(HomeError('Failed to fetch users'));
    }
  }
}
