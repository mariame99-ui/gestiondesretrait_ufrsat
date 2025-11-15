import 'package:flutter/material.dart';

class EnvoiScreen extends StatefulWidget {
  const EnvoiScreen({super.key});

  @override
  State<EnvoiScreen> createState() => _EnvoiArgentScreenState();
}

class _EnvoiArgentScreenState extends State<EnvoiScreen> {
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _destinataireController = TextEditingController();

  void _envoyerArgent() {
    final montantText = _montantController.text;
    final destinataire = _destinataireController.text;

    if (montantText.isEmpty || destinataire.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    double? montant = double.tryParse(montantText);
    if (montant == null || montant <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Montant invalide")),
      );
      return;
    }

    // Ici tu peux appeler ton API ou service de paiement
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Vous avez envoyé $montant € à $destinataire")),
    );

    _montantController.clear();
    _destinataireController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Envoyer de l'argent"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _destinataireController,
              decoration: InputDecoration(
                labelText: "Destinataire (email ou numéro)",
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
                labelText: "Montant (€)",
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
