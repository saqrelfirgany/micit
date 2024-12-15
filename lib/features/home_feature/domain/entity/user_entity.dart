import '../../data/models/user_model.dart';

class UserEntity {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
}

extension UserModelToEntity on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
    );
  }
}

extension UserModelListToEntityList on List<UserModel> {
  List<UserEntity> toEntityList() {
    return map((userModel) => userModel.toEntity()).toList();
  }
}