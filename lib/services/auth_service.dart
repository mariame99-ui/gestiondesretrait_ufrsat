import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String nom,
    required String prenom,
    required String matricule,
    required String typePension,
    required DateTime dateNaissance,
    required String email,
    required String password,
  }) async {
    // 1️⃣ Création Auth
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    // 2️⃣ Création Model
    final user = UserModel(
      uid: uid,
      nom: nom,
      prenom: prenom,
      matricule: matricule,
      typePension: typePension,
      dateNaissance: dateNaissance,
      email: email,
      solde: 0, // solde initial
      cardNumber: _generateCardNumber(),
      createdAt: DateTime.now(),
    );

    // 3️⃣ Enregistrement Firestore
    await _db.collection('users').doc(uid).set(user.toMap());
  }

  String _generateCardNumber() {
    return (1000 + DateTime.now().millisecondsSinceEpoch % 9000).toString();
  }
}
