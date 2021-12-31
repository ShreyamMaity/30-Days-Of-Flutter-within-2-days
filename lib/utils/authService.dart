


// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var usersname ;
var useremail;
var usersmob;
var usersgender;

class AuthenticationService{

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
    
  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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
      .doc(user!.uid).set({ 'name': name,'email': email, 'phone': 'enter mobile number', 'gender': 'set gender'});
      return 'Signed Up';
    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}


class FirestoreService{
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> getUserUID() async {
    final User? user = auth.currentUser;
    return user?.uid;
  }

  Future<void> loadData({required String uid}) async {
    await FirebaseFirestore.instance.collection('userData').doc(uid).get().then((value) {
         usersname = value.data()!['name'];
         useremail = value.data()!['email'];
         usersmob = value.data()!['phone'];
         usersgender = value.data()!['gender'];
      } );
    }

  Future<String?> updateData({required String phone,required String gender,required String uid}) async {
    await FirebaseFirestore.instance.collection('userData').doc(uid).update(
      {
       'phone': phone,
        'gender': gender});
        return "Profile Data Updated";
        }
  
  
  }