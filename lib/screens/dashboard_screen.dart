import 'package:flutter/material.dart';
import 'profil_screen.dart';
import 'reclamation_screen.dart';
import 'payment_history_screen.dart';
import 'solde_screen.dart';
import 'retrait_screen.dart';
import 'envoi_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau de bord"),
        backgroundColor: Colors.orange, // AppBar en orange
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildMenuCard(
              icon: Icons.account_balance,
              label: "Solde",
              onTap: () {
                Navigator.push(context
                  , MaterialPageRoute(builder:  (context)=>const SoldeScreen()),
                );
              },
            ),

            _buildMenuCard(
              icon: Icons.receipt_long,
              label: "Historique",
              onTap: () {
                Navigator.push(context
                    , MaterialPageRoute(builder:  (context)=>const PaymentHistoryScreen()),
                );
              },
            ),
            _buildMenuCard(
              icon: Icons.mark_email_read,
              label: "Réclamation",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReclamationScreen()),
                );
              },
            ),
            _buildMenuCard(
              icon: Icons.person,
              label: "Profil",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.orange), // Icône en orange
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange, // Texte en orange
              ),
            ),
          ],
        ),
      ),
    );
  }
}
