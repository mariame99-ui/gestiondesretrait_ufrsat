import 'package:flutter/material.dart';
import '../services/fake_database.dart';
import 'envoi_screen.dart';
import 'retrait_screen.dart';

class SoldeScreen extends StatefulWidget {
  const SoldeScreen({super.key});

  @override
  State<SoldeScreen> createState() => _SoldeScreenState();
}

class _SoldeScreenState extends State<SoldeScreen> {
  int solde = 0;

  @override
  void initState() {
    super.initState();
    // Initialiser le solde à partir de FakeDatabase
    solde = FakeDatabase.getSolde();
  }

  // 🔹 Rafraîchir le solde après chaque transaction
  void _refreshSolde() {
    setState(() {
      solde = FakeDatabase.getSolde();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solde"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Affichage du solde
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
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
                      color: Color(0xFF004AAD),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "$solde FCFA",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Actions : Transfert / Retrait
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionCard(
                  icon: Icons.send,
                  label: "Transfert",
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnvoiScreen(),
                      ),
                    );
                    _refreshSolde(); // Met à jour le solde après retour
                  },
                ),
                _buildActionCard(
                  icon: Icons.money,
                  label: "Retrait",
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RetraitScreen(),
                      ),
                    );
                    _refreshSolde();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---- Carte cliquable ----
  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.orange),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004AAD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
