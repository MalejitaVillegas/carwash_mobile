import 'package:carwash/screens/models/servicesModel.dart';
import 'package:carwash/services/servicesDetailScreen.dart';
import 'package:flutter/material.dart';

class GridItemService extends StatelessWidget {
  final ServicesModel services;

  GridItemService({required this.services});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ServicesDetailScreen(services: services)),
        );
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de fondo
            Image.network(
              services.photo,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.3),
            ),

            // Texto en el centro
            Center(
              child: Text(
                services.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
