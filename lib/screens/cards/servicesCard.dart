import 'package:carwash/services/servicesDetailScreen.dart';
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String serviceName;
  final String backgroundImageUrl;

  GridItem({required this.serviceName, required this.backgroundImageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServicesDetailScreen()),
        );
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de fondo
            Image.network(
              backgroundImageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.3),
            ),

            // Texto en el centro
            Center(
              child: Text(
                serviceName,
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
