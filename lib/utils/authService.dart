


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService{

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
    
  Future<String?> signIn({required String email, required String password}) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await FirebaseFirestore.instance.collection('userData').doc(user!.uid).get().then((value) {
        var usersname = value.data()!['firstName'];
        var useremail = value.data()!['email'];
        print(usersname);
        print(useremail);
      } );
      return 'Signed In';
    }on FirebaseAuthException catch (e) {
      return e.message;
    }

  }

  Future<String?> signUp({required String email, required String password, required String name}) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await FirebaseFirestore.instance.collection('userData')
      .doc(user!.uid).set({ 'name': name,'email': email,});
      return 'Signed Up';
    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}