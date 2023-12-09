import 'package:carwash/screens/models/servicesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ServicesDetailScreen extends StatefulWidget {
  final ServicesModel services;

  ServicesDetailScreen({
    super.key,
    required this.services,
  });

  @override
  _DetalleServicioScreenState createState() => _DetalleServicioScreenState();
}

class _DetalleServicioScreenState extends State<ServicesDetailScreen> {
  // Valor inicial del selector de tipo de vehículo
  String selectedVehicle = 'Carro';

  // Fecha seleccionada inicialmente
  DateTime selectedDate = DateTime.now();
  final double valorProducto = 30.0;

  // Método para mostrar el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
          Duration(days: 365)), // Puedes ajustar el rango de fechas permitido
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/header.jpeg',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        title: Text(widget.services.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),

            // Imagen del Producto (Banner)
            Image.network(
              widget.services.photo,
              height: 200.0,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 16.0),

            // Descripción del Servicio
            Text(
              widget.services.description,
              style: TextStyle(fontSize: 16.0),
            ),

            SizedBox(height: 16.0),
            // Selector de Tipo de Vehículo
            DropdownButton<String>(
              onChanged: (newValue) {
                setState(() {
                  selectedVehicle = newValue!;
                });
              },
              value: selectedVehicle,
              items: <String>['Moto', 'Carro', 'Camioneta']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 16.0),

            // Calendario de Reserva
            InkWell(
              onTap: () => _selectDate(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Fecha de Reserva'),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.0),
            // Valor del Producto
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Text(
                'Valor: \$ ${widget.services.price}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 32.0),

            // Botón de Reservar
            ElevatedButton(
              onPressed: () {
                // Mostrar modal de reserva
                saveReserve(context);
              },
              child: Text('Reservar'),
            ),
          ],
        ),
      ),
    );
  }

  void saveReserve(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection("reserve").add({
      'name': widget.services.title,
      'price': widget.services.price,
      'type': selectedVehicle,
      'date': selectedDate,
      'uid': uid,
    }).then((value) {
      _mostrarModalReserva(context);
    });
  }

  // Método para mostrar el modal de reserva
  void _mostrarModalReserva(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reserva Exitosa'),
          content: Text(
              'Tu reserva para el ${selectedDate.toLocal()} ha sido confirmada.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el modal
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
