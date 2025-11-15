import 'package:flutter/material.dart';

class RetraitScreen extends StatefulWidget {
  const RetraitScreen({super.key});

  @override
  State<RetraitScreen> createState() => _RetraitArgentScreenState();
}

class _RetraitArgentScreenState extends State<RetraitScreen> {
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _compteController = TextEditingController();

  void _retirerArgent() {
    final montantText = _montantController.text;
    final compte = _compteController.text;

    if (montantText.isEmpty || compte.isEmpty) {
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

    // Ici tu peux appeler ton API ou service de retrait
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Vous avez retiré $montant € vers $compte")),
    );

    _montantController.clear();
    _compteController.clear();
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
                labelText: "Montant (€)",
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
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
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
