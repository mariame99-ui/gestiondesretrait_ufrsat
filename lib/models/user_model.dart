import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String nom;
  final String prenom;
  final String matricule;
  final String typePension;
  final DateTime dateNaissance;
  final String email;

  // Champs système
  final double solde;
  final String cardNumber;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.nom,
    required this.prenom,
    required this.matricule,
    required this.typePension,
    required this.dateNaissance,
    required this.email,
    required this.solde,
    required this.cardNumber,
    required this.createdAt,
  });

  /// Pour enregistrer dans Firestore
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'matricule': matricule,
      'typePension': typePension,
      'dateNaissance': dateNaissance,
      'email': email,
      'solde': solde,
      'cardNumber': cardNumber,
      'createdAt': createdAt,
    };
  }

  /// Pour lire depuis Firestore
  factory UserModel.fromFirestore(
      Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      nom: data['nom'],
      prenom: data['prenom'],
      matricule: data['matricule'],
      typePension: data['typePension'],
      dateNaissance: (data['dateNaissance'] as Timestamp).toDate(),
      email: data['email'],
      solde: (data['solde'] ?? 0).toDouble(),
      cardNumber: data['cardNumber'] ?? '0000',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
