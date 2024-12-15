part of 'login_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final UserAuthModel userModel;
  AuthSuccess(this.userModel);
}
class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
