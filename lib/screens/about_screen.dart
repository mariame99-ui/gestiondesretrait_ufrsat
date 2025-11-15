import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("À propos"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Gestion des Retraités UFRSAT",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004AAD),
              ),
            ),
            const SizedBox(height: 15),

            const Text(
              "Cette application a été conçue pour faciliter la gestion des "
                  "retraités de l’UFRSAT. Elle permet :\n\n"
                  "• l’enregistrement des retraités\n"
                  "• la gestion des informations personnelles\n"
                  "• la consultation rapide des données\n"
                  "• la centralisation des dossiers\n",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

            const SizedBox(height: 25),

            const Text(
              "Développeurs",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "• Equipe UFRSAT\n"
                  "• Autres développeurs participants\n\n",
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 20),

            const Text(
              "Version : 1.0.0",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),

            const Spacer(),

            Center(
              child: Text(
                "© 2025 UFRSAT - Tous droits réservés",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
