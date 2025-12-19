import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Connexion réussie ✅"),
            backgroundColor: Colors.green,
          ),
        );

        // Redirection vers Dashboard
        Navigator.pushReplacementNamed(context, '/dashboard');

      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? "Erreur de connexion ❌"),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004AAD),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRouter.home);
          },
        ),
        title: const Text("Connexion"),
        centerTitle: true,
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
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Bienvenue",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Connectez-vous à votre compte",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 32),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                          _inputStyle("Adresse email", Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email requis";
                            }
                            if (!value.contains('@')) return "Email invalide";
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration:
                          _inputStyle("Mot de passe", Icons.lock_outline),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Mot de passe requis";
                            }
                            if (value.length < 4) return "Minimum 4 caractères";
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004AAD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : const Text(
                              "Se connecter",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Pas encore de compte ? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRouter.register);
                              },
                              child: const Text(
                                "Créer un compte",
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
