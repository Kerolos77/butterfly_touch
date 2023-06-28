import 'package:butterfly_touch/data/models/barcode_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../constants/conestant.dart';
import '../models/user_model.dart';
import 'firebase_options.dart';

class FirebaseReposatory {
  static FirebaseFirestore firebase = FirebaseFirestore.instance;

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> createUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    UserModel userDataModel = UserModel(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      score: 0,
    );
    return firebase.collection('users').doc(userId).set(userDataModel.toMap());
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    return FirebaseAuth.instance.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return firebase.collection('users').doc(constUid).get();
  }

  Future<void> createBarcode({
    required String barcode,
    required bool isGood,
    required String description,
  }) async {
    BarcodeModel barcodeDataModel = BarcodeModel(
      barcode: barcode,
      isGood: isGood,
      description: description,
    );
    return firebase
        .collection('barcodes')
        .doc(barcode)
        .set(barcodeDataModel.toMap());
  }

  Future<void> deleteBarcode({
    required String barcode,
  }) async {
    return firebase.collection('barcodes').doc(barcode).delete();
  }
}
