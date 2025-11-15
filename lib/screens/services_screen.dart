import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des services
    final services = [
      {
        "title": "À propos",
        "icon": Icons.info_outline,
        "color": Colors.blue.shade100,
        "route": "/about",
      },
      {
        "title": "Contact",
        "icon": Icons.phone_outlined,
        "color": Colors.green.shade100,
        "route": "/contact",
      },

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // tu peux mettre 2 pour tablette ou landscape
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 4, // card horizontale
          ),
          itemBuilder: (context, index) {
            final service = services[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, service["route"] as String);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: service["color"] as Color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      service["icon"] as IconData,
                      size: 36,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        service["title"] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black38),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
