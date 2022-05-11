import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning/module/user.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserM? _userFromFirebaseUser(User user) {
    return user != null ? UserM(uid: user.uid) : null;
  }

  Future signInEmailAndPass(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future SignUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future SignOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
