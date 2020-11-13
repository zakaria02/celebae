import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // if the user logged in or out the state will gonna be changed
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // GET current user
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    final curentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Add Username
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = username;
    await curentUser.user.updateProfile(userUpdateInfo);
    await curentUser.user.reload();
    return curentUser.user.uid;
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  // Update email
  Future updateEmail(String email, String password, String newEmail) async {
    final user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return await user.updateEmail(newEmail);
  }

  // Update password
  Future updatePassword(
      String email, String password, String newPassword) async {
    final user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return await user.updatePassword(newPassword);
  }

  // Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Create AnonymousUser
  Future signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }
}
