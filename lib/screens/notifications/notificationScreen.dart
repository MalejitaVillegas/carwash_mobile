import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificacionesScreenState createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificationScreen> {
  List<Notificacion> notificaciones = [
    Notificacion(
      titulo: 'Nuevo mensaje',
      descripcion: 'Tienes un nuevo mensaje de prueba.',
      hora: DateTime.now(),
    ),
    Notificacion(
      titulo: 'Recordatorio',
      descripcion: 'Recuerda realizar la reserva.',
      hora: DateTime.now().subtract(Duration(minutes: 30)),
    ),
    // Puedes agregar más notificaciones según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/header.jpeg',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        title: Text('Notificaciones'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        child: ListView.builder(
          itemCount: notificaciones.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(notificaciones[index].hora.toString()),
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete, color: Colors.white),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
              ),
              onDismissed: (direction) {
                // Eliminar la notificación al deslizar
                setState(() {
                  notificaciones.removeAt(index);
                });
                // Mostrar un snackbar para confirmar la eliminación
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Notificación eliminada'),
                    action: SnackBarAction(
                      label: 'Deshacer',
                      onPressed: () {
                        setState(() {
                          // Si el usuario deshace, restaura la notificación
                          notificaciones.insert(index, notificaciones[index]);
                        });
                      },
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(notificaciones[index].titulo),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notificaciones[index].descripcion),
                    SizedBox(height: 4.0),
                    Text(
                      'Hora: ${notificaciones[index].hora.hour}:${notificaciones[index].hora.minute}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                leading: Icon(Icons.notifications),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Notificacion {
  final String titulo;
  final String descripcion;
  final DateTime hora;

  Notificacion({
    required this.titulo,
    required this.descripcion,
    required this.hora,
  });
}
