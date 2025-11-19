import 'package:flutter/material.dart';
import '../services/fake_database.dart';

class RetraitScreen extends StatefulWidget {
  const RetraitScreen({super.key});

  @override
  State<RetraitScreen> createState() => _RetraitScreenState();
}

class _RetraitScreenState extends State<RetraitScreen> {
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _compteController = TextEditingController();

  void _retirerArgent() {
    final montantText = _montantController.text;
    final compte = _compteController.text.trim();

    if (montantText.isEmpty || compte.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    int? montant = int.tryParse(montantText);
    if (montant == null || montant <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Montant invalide")),
      );
      return;
    }

    if (FakeDatabase.getSolde() < montant) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Solde insuffisant")),
      );
      return;
    }

    // Retrait via FakeDatabase
    FakeDatabase.retirerSolde(montant);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Vous avez retiré $montant FCFA vers $compte"),
        backgroundColor: Colors.green,
      ),
    );

    _montantController.clear();
    _compteController.clear();

    // Retour à l'écran précédent pour rafraîchir le solde
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Retrait d'argent"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _compteController,
              decoration: InputDecoration(
                labelText: "Compte ou méthode de retrait",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _montantController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Montant (FCFA)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _retirerArgent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              ),
              child: const Text(
                "Retirer",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
