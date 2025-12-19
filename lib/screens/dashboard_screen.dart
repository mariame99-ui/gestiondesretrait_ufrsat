import 'package:flutter/material.dart';

// Screens
import 'profil_screen.dart';
import 'reclamation_screen.dart';
import 'payment_history_screen.dart';
import 'solde_screen.dart';
import 'retrait_screen.dart';
import 'envoi_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardHome(),
    ServicesScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,

      endDrawer: const RightMenu(),

      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        title: const Text(
          "Tableau de bord",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0A3D62),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            activeIcon: Icon(Icons.apps),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: "Paramètres",
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 🏠 DASHBOARD HOME (Carte large + cards images)
////////////////////////////////////////////////////////////

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),

        /// 💳 CARTE BANCAIRE LARGE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              image: const DecorationImage(
                image: AssetImage("assets/images/"), // image carte bancaire
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Solde actuel",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 10),
                Text(
                  "350 000 FCFA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// 🤍 CONTAINER BLANC COMME HOME
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),

            /// 🟦 GRID DES SERVICES (IMAGES)
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
              children: [
                _imageCard(context, "Solde", "assets/images/wallet.png", const SoldeScreen()),
                _imageCard(context, "Historique", "assets/images/history.png", const PaymentHistoryScreen()),
                _imageCard(context, "Réclamation", "assets/images/reclamation.png", const ReclamationScreen()),
                _imageCard(context, "Profil", "assets/images/profile.png", const ProfileScreen()),
                _imageCard(context, "Envoi", "assets/images/send.png", const EnvoiScreen()),
                _imageCard(context, "Retrait", "assets/images/withdraw.png", const RetraitScreen()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 🖼️ CARDS SERVICES (IMAGES UNIQUEMENT)
  Widget _imageCard(BuildContext context, String title, String image, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.55),
                Colors.transparent,
              ],
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 📂 MENU DROIT
////////////////////////////////////////////////////////////

class RightMenu extends StatelessWidget {
  const RightMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF004AAD)),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
            accountName: const Text("Gaye Yaya"),
            accountEmail: const Text("email@email.com"),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Mon profil"),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Déconnexion", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 📦 SERVICES & ⚙️ PARAMÈTRES
////////////////////////////////////////////////////////////

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Services"));
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Paramètres"));
}
