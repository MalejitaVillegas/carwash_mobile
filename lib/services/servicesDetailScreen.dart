import 'package:flutter/material.dart';

class ServicesDetailScreen extends StatefulWidget {
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
        title: Text('Lavado general'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),

            // Imagen del Producto (Banner)
            Image.network(
              'https://cmsresources.elempleo.com/co/assets/backend/styles/770x513/public/2023-09/autos%20(1)_0.jpg',
              height: 200.0,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 16.0),

            // Descripción del Servicio
            Text(
              'Descripción detallada del servicio de lavado general. '
              'Incluye lavado exterior e interior, aspirado, y más.',
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
                'Valor: \$30.00',
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
                _mostrarModalReserva(context);
              },
              child: Text('Reservar'),
            ),
          ],
        ),
      ),
    );
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
