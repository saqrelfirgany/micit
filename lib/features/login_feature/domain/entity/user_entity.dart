class UserEntity {
  final String uid;
  final String displayName;
  final String email;
  final bool isEmailVerified;
  final String? photoURL;

  UserEntity({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.isEmailVerified,
    this.photoURL,
  });
}
