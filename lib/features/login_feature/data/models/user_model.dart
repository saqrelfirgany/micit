import '../../domain/entity/user_entity.dart';

class UserModel {
  final String displayName;
  final String email;
  final bool isEmailVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String photoURL;
  final String? refreshToken;
  final String? tenantId;
  final String uid;

  UserModel({
    required this.displayName,
    required this.email,
    required this.isEmailVerified,
    required this.isAnonymous,
    this.phoneNumber,
    required this.photoURL,
    this.refreshToken,
    this.tenantId,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'],
      email: json['email'],
      isEmailVerified: json['isEmailVerified'],
      isAnonymous: json['isAnonymous'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      refreshToken: json['refreshToken'],
      tenantId: json['tenantId'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'isAnonymous': isAnonymous,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'refreshToken': refreshToken,
      'tenantId': tenantId,
      'uid': uid,
    };
  }

  // Convert Model to Entity
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      displayName: displayName,
      email: email,
      isEmailVerified: isEmailVerified,
      photoURL: photoURL,
    );
  }
}
