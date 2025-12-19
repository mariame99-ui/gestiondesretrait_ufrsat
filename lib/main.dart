import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/router.dart';
import 'firebase_options.dart'; // généré par FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion des Retraités UFRSAT',
      theme: ThemeData(
        primaryColor: const Color(0xFF004AAD),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF004AAD),
          secondary: const Color(0xFF004AAD),
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.home,
      routes: AppRouter.routes,
    );
  }
}
