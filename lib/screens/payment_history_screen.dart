import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemple d’historique des paiements
    final payments = [
      {"date": "12 Janvier 2025", "montant": "50 000 FCFA"},
      {"date": "12 Décembre 2024", "montant": "50 000 FCFA"},
      {"date": "12 Novembre 2024", "montant": "50 000 FCFA"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des paiements"),
        backgroundColor: Colors.orange, // AppBar en orange
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final item = payments[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orange.shade200), // bordure orange
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
                Text(
                  item["date"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange, // texte date en orange
                  ),
                ),
                Text(
                  item["montant"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange, // texte montant en orange
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
