import 'package:flutter/material.dart';
import '../config/router.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final matriculeController = TextEditingController();
  final birthDateController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  String? selectedPensionType;

  final List<String> pensionTypes = [
    'Pension directe',
    'Réversion',
    'Invalidité',
  ];

  // =======================
  // 🎨 STYLE INPUT
  // =======================
  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  // =======================
  // 📅 DATE PICKER
  // =======================
  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1960),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthDateController.text =
      "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }

  DateTime _parseDate(String date) {
    final parts = date.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  // =======================
  // 🔐 INSCRIPTION
  // =======================
  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await AuthService().registerUser(
        nom: nomController.text.trim(),
        prenom: prenomController.text.trim(),
        matricule: matriculeController.text.trim(),
        typePension: selectedPensionType!,
        dateNaissance: _parseDate(birthDateController.text),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Inscription réussie ✅"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacementNamed(context, '/dashboard');

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // =======================
  // 🧹 CLEAN
  // =======================
  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    matriculeController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // =======================
  // 🖼️ UI
  // =======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004AAD),
        title: const Text("Créer un compte"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRouter.home),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF004AAD), Color(0xFF6A9CFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 14,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nomController,
                          decoration: _inputStyle("Nom", Icons.person_outline),
                          validator: (v) =>
                          v!.isEmpty ? "Nom requis" : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: prenomController,
                          decoration:
                          _inputStyle("Prénom", Icons.person_outline),
                          validator: (v) =>
                          v!.isEmpty ? "Prénom requis" : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: matriculeController,
                          decoration: _inputStyle(
                              "Matricule / N° pension",
                              Icons.badge_outlined),
                          validator: (v) =>
                          v!.isEmpty ? "Matricule requis" : null,
                        ),
                        const SizedBox(height: 16),

                        DropdownButtonFormField<String>(
                          decoration: _inputStyle(
                              "Type de pension",
                              Icons.assignment_outlined),
                          value: selectedPensionType,
                          items: pensionTypes
                              .map((type) => DropdownMenuItem(
                              value: type, child: Text(type)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => selectedPensionType = v),
                          validator: (v) =>
                          v == null ? "Choix requis" : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: birthDateController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: _inputStyle(
                              "Date de naissance",
                              Icons.calendar_today_outlined),
                          validator: (v) =>
                          v!.isEmpty ? "Date requise" : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputStyle(
                              "Adresse email", Icons.email_outlined),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Email requis";
                            }
                            if (!v.contains('@')) {
                              return "Email invalide";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: _inputStyle(
                              "Mot de passe", Icons.lock_outline),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Mot de passe requis";
                            }
                            if (v.length < 4) {
                              return "Minimum 4 caractères";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004AAD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                color: Colors.white)
                                : const Text(
                              "Créer un compte",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Déjà inscrit ? "),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, AppRouter.login),
                              child: const Text(
                                "Se connecter",
                                style: TextStyle(
                                  color: Color(0xFF004AAD),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
