import 'package:flutter/material.dart';
import '../services/fake_database.dart';

class EnvoiScreen extends StatefulWidget {
  const EnvoiScreen({super.key});

  @override
  State<EnvoiScreen> createState() => _EnvoiArgentScreenState();
}

class _EnvoiArgentScreenState extends State<EnvoiScreen> {
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _destinataireController = TextEditingController();

  void _envoyerArgent() {
    final montantText = _montantController.text.trim();
    final destinataire = _destinataireController.text.trim();

    if (montantText.isEmpty || destinataire.isEmpty) {
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

    if (destinataire == FakeDatabase.utilisateurActuel) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vous ne pouvez pas vous envoyer de l'argent")),
      );
      return;
    }

    if (!FakeDatabase.soldes.containsKey(destinataire)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Destinataire introuvable")),
      );
      return;
    }

    if (FakeDatabase.getSolde() < montant) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Solde insuffisant")),
      );
      return;
    }

    // 🔹 Mise à jour de la base de données
    FakeDatabase.envoyer(montant, destinataire);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Vous avez envoyé $montant FCFA à $destinataire")),
    );

    // Réinitialisation des champs
    _montantController.clear();
    _destinataireController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final solde = FakeDatabase.getSolde();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Envoyer de l'argent"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Solde actuel : $solde FCFA",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _destinataireController,
              decoration: InputDecoration(
                labelText: "Destinataire (email)",
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
              onPressed: _envoyerArgent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              ),
              child: const Text(
                "Envoyer",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
