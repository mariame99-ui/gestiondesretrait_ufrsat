import 'package:flutter/material.dart';
import '../services/fake_database.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Récupérer l'historique de l'utilisateur actuel
    final userTransactions = FakeDatabase.getHistorique().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des paiements"),
        backgroundColor: Colors.orange,
      ),
      body: userTransactions.isEmpty
          ? const Center(
        child: Text(
          "Aucune transaction pour le moment.",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: userTransactions.length,
        itemBuilder: (context, index) {
          final tx = userTransactions[index];
          final type = tx['type'] ?? 'Type inconnu';
          final montant = tx['montant']?.toString() ?? '0';
          final date = tx['date'] ?? '';

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orange.shade200),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "$type\n$date",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                  ),
                ),
                Text(
                  "$montant FCFA",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
