import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        "title": "À propos",
        "icon": Icons.info_outline,
        "route": "/about",
      },
      {
        "title": "Contact",
        "icon": Icons.phone_outlined,
        "route": "/contact",
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final service = services[index];

        return ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Icon(service["icon"] as IconData),
          title: Text(service["title"] as String),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.pushNamed(context, service["route"] as String);
          },
        );
      },
    );
  }
}

