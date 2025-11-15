import 'package:flutter/material.dart';
import 'config/router.dart';

void main() {
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
