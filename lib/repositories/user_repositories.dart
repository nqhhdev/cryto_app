import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
  UserRepository();

  // Sign Up with email and password

  Future<User?> signUp(
    String named,
    var phoneNumber,
    String email,
    String password,
  ) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(named);
      // var auth = await firebaseAuth.createUserWithEmailAndPassword(
      //     email: email, password: password);
      return credential.user!;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign In with email and password

  Future<User?> signIn(
    String email,
    String password,
  ) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user!;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // check Sign In
  Future<bool> isSignedIn() async {
    var currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  //get current user

  Future<User> getCurrentUser() async {
    return firebaseAuth.currentUser!;
  }
}
