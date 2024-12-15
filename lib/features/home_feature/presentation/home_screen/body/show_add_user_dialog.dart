import 'package:flutter/material.dart';

import '../../../../../core/dependency_injection/configure_dependencies.dart';
import '../../../domain/entity/user_entity.dart';
import '../../cubit/home_cubit.dart';

void showAddUserDialog({required BuildContext context}) {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add User'),
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
              final uniqueId = DateTime.now().millisecondsSinceEpoch;

              cubit.addUser(
                user: UserEntity(
                  id: uniqueId,
                  email: emailController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  avatar: 'avatar',
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
