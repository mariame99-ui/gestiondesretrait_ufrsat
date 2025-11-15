import 'package:flutter/material.dart';

class ReclamationScreen extends StatefulWidget {
  const ReclamationScreen({super.key});

  @override
  State<ReclamationScreen> createState() => _ReclamationScreenState();
}

class _ReclamationScreenState extends State<ReclamationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Réclamation"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Envoyer une réclamation",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004AAD),
                ),
              ),
              const SizedBox(height: 20),

              // Nom
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nom",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                value!.isEmpty ? "Veuillez entrer votre nom" : null,
              ),
              const SizedBox(height: 15),

              // Email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value!.contains("@")
                    ? null
                    : "Veuillez entrer un email valide",
              ),
              const SizedBox(height: 15),

              // Sujet
              TextFormField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: "Sujet",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                value!.isEmpty ? "Veuillez entrer un sujet" : null,
              ),
              const SizedBox(height: 15),

              // Message
              TextFormField(
                controller: messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Message",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                value!.isEmpty ? "Veuillez écrire un message" : null,
              ),
              const SizedBox(height: 25),

              // Bouton d'envoi
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendReclamation(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  child: const Text(
                    "Envoyer",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendReclamation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Réclamation envoyée avec succès !"),
      ),
    );

    // Vide les champs après envoi
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
  }
}
