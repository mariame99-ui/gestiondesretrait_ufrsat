import 'package:flutter/material.dart';
import 'package:gestiondesretrait_ufrsat/config/router.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  void _onItemTapped(int index) {
    if (index == widget.currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRouter.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/services');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF004AAD),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            activeIcon: Icon(Icons.apps),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
