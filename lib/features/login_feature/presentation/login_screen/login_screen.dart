import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:micit/core/dependency_injection/configure_dependencies.dart';
import 'package:micit/core/router/route_names.dart';

import '../../../../core/widgets/loading/button_loading.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
            if (state is AuthSuccess) {
              context.push(AppRouteName.homeScreenRoute);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity),
                  state is AuthLoading
                      ? const ButtonLoading()
                      : ElevatedButton(
                          onPressed: () {
                            serviceLocator<AuthCubit>().signInWithGoogle();
                          },
                          child: const Text('Sign In with Google'),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
