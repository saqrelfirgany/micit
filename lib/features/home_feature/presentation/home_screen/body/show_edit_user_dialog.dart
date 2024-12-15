import 'package:flutter/material.dart';

import '../../../../../core/dependency_injection/configure_dependencies.dart';
import '../../../domain/entity/user_entity.dart';
import '../../cubit/home_cubit.dart';

void showEditUserDialog({
  required BuildContext context,
  required UserEntity user,
}) {
  final firstNameController = TextEditingController(text: user.firstName);
  final lastNameController = TextEditingController(text: user.lastName);
  final emailController = TextEditingController(text: user.email);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final cubit = serviceLocator<HomeCubit>();
              cubit.editUser(
                user: UserEntity(
                  id: user.id,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  avatar: user.avatar,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
