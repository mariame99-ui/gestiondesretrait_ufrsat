import 'package:flutter/material.dart';

// Importation des écrans existants
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/about_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/services_screen.dart' hide ServicesScreen;
import '../screens/payment_history_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/profil_screen.dart';
import '../screens/reclamation_screen.dart';
import '../screens/solde_screen.dart';





// Ici chacun pourra importer ses propres écrans plus tard

class AppRouter {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  //static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    '/about': (context) => const AboutScreen(),
    '/contact': (context) => const ContactScreen(),
    '/services':(context) =>const ServicesScreen(),
     '/payments': (context) => const PaymentHistoryScreen(),
    '/dashboard': (context) => const DashboardScreen(),
     '/profile': (context) => const ProfileScreen(),
    '/reclamation': (context) => const ReclamationScreen(),
    '/solde': (context) =>const SoldeScreen(),



    //Plus tard : chacun ajoute sa ligne ici
  };

  static String? get dashboard => null;
}
