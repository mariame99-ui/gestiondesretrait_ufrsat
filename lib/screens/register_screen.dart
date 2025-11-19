import 'package:flutter/material.dart';
import '../services/fake_database.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedPensionType;

  final List<String> pensionTypes = [
    'Pension directe',
    'Réversion',
    'Invalidité',
  ];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1960),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthDateController.text =
        '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Vérifier si l'email existe déjà
      if (FakeDatabase.comptes.containsKey(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email déjà utilisé ❌"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Ajouter l'utilisateur dans FakeDatabase
      FakeDatabase.comptes[email] = password;
      FakeDatabase.soldes[email] = 0; // solde initial
      FakeDatabase.historiques[email] = [];
      FakeDatabase.reclamations[email] = [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Inscription réussie ✅"),
          backgroundColor: Colors.green,
        ),
      );

      // Redirection vers le dashboard
      Future.delayed(const Duration(milliseconds: 500), () {
        FakeDatabase.utilisateurActuel = email;
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription Pensionné"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const Text(
                "Créer un compte 📝",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              // Nom
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: "Nom",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Veuillez entrer votre nom" : null,
              ),
              const SizedBox(height: 15),
              // Prénom
              TextFormField(
                controller: prenomController,
                decoration: const InputDecoration(
                  labelText: "Prénom",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Veuillez entrer votre prénom" : null,
              ),
              const SizedBox(height: 15),
              // Matricule
              TextFormField(
                controller: matriculeController,
                decoration: const InputDecoration(
                  labelText: "Numéro matricule / N° pension",
                  prefixIcon: Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Veuillez entrer votre matricule" : null,
              ),
              const SizedBox(height: 15),
              // Type de pension
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Type de pension",
                  prefixIcon: Icon(Icons.assignment_outlined),
                  border: OutlineInputBorder(),
                ),
                value: selectedPensionType,
                items: pensionTypes
                    .map((type) =>
                    DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => selectedPensionType = value),
                validator: (value) =>
                value == null ? "Veuillez choisir un type" : null,
              ),
              const SizedBox(height: 15),
              // Date de naissance
              TextFormField(
                controller: birthDateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: const InputDecoration(
                  labelText: "Date de naissance",
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Veuillez choisir votre date" : null,
              ),
              const SizedBox(height: 15),
              // Email
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Adresse email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre email";
                  }
                  if (!value.contains('@')) {
                    return "Adresse email invalide";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Mot de passe
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Mot de passe",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un mot de passe";
                  }
                  if (value.length < 4) {
                    return "Le mot de passe doit contenir au moins 4 caractères";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              // Bouton inscription
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                  ),
                  child: const Text(
                    "Créer un compte",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // Lien vers la connexion
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous avez déjà un compte ? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(
                        color: Color(0xFF004AAD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}