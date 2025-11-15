import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Contact UFRSAT",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004AAD),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Pour toute question, vous pouvez nous contacter :\n",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            const Text(
              "📞 Téléphone : +221 33 655 32 88\n"
                  "📧 Email : contact@ufrsat.sn\n"
                  "🏢 Adresse : Campus Universitaire, SAINT-LOUIS",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const Spacer(),

            Center(
              child: Text(
                "Nous serons ravis de vous aider",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
