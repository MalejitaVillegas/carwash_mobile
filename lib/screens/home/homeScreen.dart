import 'package:carwash/screens/cards/servicesCard.dart';
import 'package:carwash/screens/models/reserveModel.dart';
import 'package:carwash/screens/models/servicesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<ServicesModel> _services = [];
  List<ReserveModel> _reserves = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _services = await retriveServices();
      _reserves = await retriveReserve();
      setState(() {});
    });
  }

  Future<List<ServicesModel>> retriveServices() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("services").get();
    return snapshot.docs
        .map((docSnapshot) => ServicesModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<ReserveModel>> retriveReserve() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("reserve").get();
    return snapshot.docs
        .map((docSnapshot) => ReserveModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

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
              const SizedBox(height: 16),
              const Text(
                'Servicio Actual',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _reserves.length,
                itemBuilder: (context, index) {
                  DateTime dateTime = _reserves[index].date.toDate();
                  DateTime newDateTime = dateTime.add(Duration(hours: 2));
                  String formattedHour = DateFormat('HH:mm').format(dateTime);
                  String formattedHourEnd =
                      DateFormat('HH:mm').format(newDateTime);
                  return _buildListItem(Icons.work, _reserves[index].name,
                      formattedHour, formattedHourEnd);
                },
              ),
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
            itemCount: _services.length,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento dentro del GridView
            itemBuilder: (context, index) {
              return GridItemService(services: _services[index]);
            },
          ),
        ],
      ),
    );
  }
}
