import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:easy_turn/notifier/profesor_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_turn/model/profesores.dart';




abstract class BaseAuth {
    Future<String> signInWithEmailAndPassword(String email, String password);
    Future<String> createUserWithEmailAndPassword(String email, String password);
    Future<String> currentUser();
    Future<void> signOut(); 
    Future<String> currentEmail();
    Future<String> email();



}

class Auth implements BaseAuth{
  
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String email, String password) async {
  FirebaseUser user = await  _fireBaseAuth.signInWithEmailAndPassword(email: email.toString().trim(), password: password);
          
            return user.uid;

  }
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
   FirebaseUser user = await  _fireBaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    user.sendEmailVerification();
    
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await  _fireBaseAuth.currentUser();
    return user != null ? user.uid : null;
  }
   Future<String> currentEmail() async {
    FirebaseUser user = await  _fireBaseAuth.currentUser();
    return user.email;
  }

  Future<void> signOut() async{
    return  _fireBaseAuth.signOut();
  }

    Future<String> email() async{
              FirebaseUser user =await FirebaseAuth.instance.currentUser();
              String email;
              email = user.email;
              print(email);
              return email;
    }




}

