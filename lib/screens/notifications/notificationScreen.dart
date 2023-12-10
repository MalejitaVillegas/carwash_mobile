import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificacionesScreenState createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificationScreen> {
  List<Notificacion> _notificaciones = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _notificaciones = await retriveNotifications();
      setState(() {});
    });
  }

  Future<List<Notificacion>> retriveNotifications() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("notifications").get();
    return snapshot.docs
        .map((docSnapshot) => Notificacion.fromDocumentSnapshot(docSnapshot))
        .toList();
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
        title: Text('Notificaciones'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        child: ListView.builder(
          itemCount: _notificaciones.length,
          itemBuilder: (context, index) {
            DateTime dateTime = _notificaciones[index].hora.toDate();

            String formattedHour = DateFormat('HH:mm').format(dateTime);

            return Dismissible(
              key: Key(_notificaciones[index].hora.toString()),
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete, color: Colors.white),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
              ),
              onDismissed: (direction) {
                // Eliminar la notificación al deslizar
                setState(() {
                  _notificaciones.removeAt(index);
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
                          _notificaciones.insert(index, _notificaciones[index]);
                        });
                      },
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(_notificaciones[index].titulo),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_notificaciones[index].descripcion),
                    const SizedBox(height: 4.0),
                    Text(
                      'Hora: $formattedHour',
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
  final hora;

  Notificacion({
    required this.titulo,
    required this.descripcion,
    required this.hora,
  });

  Notificacion.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : titulo = doc.data()!["title"],
        descripcion = doc.data()!["description"],
        hora = doc.data()!["date"];
}
