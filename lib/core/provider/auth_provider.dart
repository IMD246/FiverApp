import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

abstract class AuthProvider {
  Future<dynamic> signIn();
}

class AuthGoogleProvider implements AuthProvider {
  @override
  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (e) {
      log('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      log('Error signing in with Google: $e');
    }
  }
}

class AuthFacebookProvider extends AuthProvider {
  @override
  Future<GoogleSignInAccount?> signIn() async {
    throw UnimplementedError();
  }
}
