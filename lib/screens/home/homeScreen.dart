import 'package:carwash/screens/cards/ServicesCard.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [header(), myServices(), hireService()],
      ),
    );
  }

  Widget header() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/header.jpeg',
          fit: BoxFit.cover,
          height: 190,
          width: double.infinity,
        ),
        infoHeader()
      ],
    );
  }

  Widget infoHeader() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 140,
          ),
          CircleAvatar(
            radius: 40,
          ),
          Text("Sammuel Ramos"),
          Text("Colombias")
        ],
      ),
    );
  }

  Widget myServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Sección de Mis Servicios
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Servicio Actual',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildListItem(Icons.work, 'Trabajo', '09:00 AM', '06:00 PM'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(IconData icon, String descripcion, String horaEntrada,
      String horaSalida) {
    return ListTile(
      leading: Icon(icon, size: 40.0),
      title: Text(descripcion),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hora de Entrada: $horaEntrada'),
          Text('Hora de Salida: $horaSalida'),
        ],
      ),
    );
  }

  Widget hireService() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          const Text(
            'Contratar Servicio',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: 4,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento dentro del GridView
            itemBuilder: (context, index) {
              return GridItem(
                serviceName: 'Servicio ${index + 1}',
                backgroundImageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbeKB3gX_dXRKU9WpvWLGs47kqACRG_4uABl5Ufi3JENSi_MGTHWknpJQTqBdejSXay_Q&usqp=CAU',
              );
            },
          ),
        ],
      ),
    );
  }
}
