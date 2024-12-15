import 'package:flutter/material.dart';

import '../../../../../core/dependency_injection/configure_dependencies.dart';
import '../../cubit/home_cubit.dart';

void deleteUser({required BuildContext context, required int userId}) {
  final cubit = serviceLocator<HomeCubit>();
  cubit.deleteUser(userId: userId);
}