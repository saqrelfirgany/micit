import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserAuthModel> signInWithGoogle();

  Future<UserAuthModel> signInWithEmail(String email, String password);

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =
      GoogleSignIn(forceCodeForRefreshToken: true);

  AuthRemoteDataSourceImpl();

  @override
  Future<UserAuthModel> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google Sign-In canceled.');

    final googleAuth = await googleUser.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final firebaseUser = userCredential.user!;

    return UserAuthModel(
      uid: firebaseUser.uid,
      displayName: firebaseUser.displayName ?? 'displayName',
      email: firebaseUser.email ?? 'email',
      isEmailVerified: !firebaseUser.isAnonymous,
      photoURL: firebaseUser.photoURL ?? 'photoURL',
      isAnonymous: firebaseUser.isAnonymous,
    );
  }

  @override
  Future<UserAuthModel> signInWithEmail(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = userCredential.user!;

    return UserAuthModel(
      uid: firebaseUser.uid,
      displayName: firebaseUser.displayName ?? 'displayName',
      email: firebaseUser.email ?? 'email',
      isEmailVerified: !firebaseUser.isAnonymous,
      photoURL: firebaseUser.photoURL ?? 'photoURL',
      isAnonymous: firebaseUser.isAnonymous,
    );
  }

  @override
  Future<void> logout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }
}
