import 'package:flutter/material.dart';

class SoldeScreen extends StatelessWidget {
  const SoldeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final solde = 150000; // Exemple de solde

    return Scaffold(
      appBar: AppBar(
        title: const Text("Solde"),
        backgroundColor: const Color(0xFF004AAD), // bleu
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.orange.shade100, // fond clair orange
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Votre solde actuel",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF004AAD), // texte bleu
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "$solde FCFA",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange, // montant en orange
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Actions rapides
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionCard(icon: Icons.send, label: "Transfert"),
                _buildActionCard(icon: Icons.money, label: "Retrait"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({required IconData icon, required String label}) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50, // fond bleu clair
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.orange), // icône orange
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004AAD), // texte bleu
            ),
          ),
        ],
      ),
    );
  }
}
