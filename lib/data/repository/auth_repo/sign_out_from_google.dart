import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
Future<bool> signOutFromGoogle() async {
  try {
    await _googleSignIn.disconnect();

    await _googleSignIn.signOut();

    return true;
  } catch (e) {
    print('Error signing out from Google: $e');
    return false;
  }
}