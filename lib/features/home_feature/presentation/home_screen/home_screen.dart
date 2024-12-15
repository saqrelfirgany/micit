import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micit/core/dependency_injection/configure_dependencies.dart';
import 'package:micit/core/widgets/app_bar/main_app_bar.dart';

import '../../../../core/widgets/loading/screen_loading.dart';
import '../cubit/home_cubit.dart';
import 'body/delete_user.dart';
import 'body/show_add_user_dialog.dart';
import 'body/show_edit_user_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<HomeCubit>()..fetchUsers(),
      child: Scaffold(
        appBar: MainAppBar(
          title: 'MICIT',
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showAddUserDialog(context: context),
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const ScreenLoading();
            } else if (state is HomeLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => showEditUserDialog(
                            context: context,
                            user: user,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteUser(
                            context: context,
                            userId: user.id,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: state is HomeLoading
                    ? null
                    : () async {
                        await serviceLocator<HomeCubit>().syncData();
                      },
                child: const Text('Sync Data'),
              ),
            );
          },
        ),
      ),
    );
  }
}
