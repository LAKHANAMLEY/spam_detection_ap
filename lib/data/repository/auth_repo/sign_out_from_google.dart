import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _fAuth = FirebaseAuth.instance;
Future<bool> signOutFromGoogle() async {
  try {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await _fAuth.signOut();
    return true;
  } catch (e) {
    print('Error signing out from Google: $e');
    return false;
  }
}
