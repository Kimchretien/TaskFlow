//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();


  //sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async{
    await _auth.signInWithEmailAndPassword(email: email, password: password);

  }


  Future<void> signOut() async{
    await _auth.signOut();
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async{
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential?> signInWithGoogle() async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on Exception catch(e){
      //print('exception->$e');
    }
  } 

}