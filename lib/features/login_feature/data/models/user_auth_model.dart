import '../../domain/entity/user_auth_entity.dart';

class UserAuthModel {
  final String displayName;
  final String email;
  final bool isEmailVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String photoURL;
  final String? refreshToken;
  final String? tenantId;
  final String uid;

  UserAuthModel({
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

  factory UserAuthModel.fromJson(Map<String, dynamic> json) {
    return UserAuthModel(
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
  UserAuthEntity toEntity() {
    return UserAuthEntity(
      uid: uid,
      displayName: displayName,
      email: email,
      isEmailVerified: isEmailVerified,
      photoURL: photoURL,
    );
  }
}
