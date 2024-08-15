import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final _googleSignIn = GoogleSignIn();
  GoogleSignInService._();

  static final GoogleSignInService instance = GoogleSignInService._();
  Future<GoogleSignInAccount?> signIn() async {
    try {
      return _googleSignIn.signIn();
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<GoogleSignInAccount?> signOut() async {
    try {
      return _googleSignIn.signOut();
    } catch (e) {
      print('Error signing out of Google: $e');
      return null;
    }
  }

}