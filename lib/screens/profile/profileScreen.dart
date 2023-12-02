import 'package:carwash/screens/login/loginScreen.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/header.jpeg',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        title: Text('Mi Perfil'),
      ),
      body: Center(
        child: Column(
          children: [
            // Avatar
            SizedBox(height: 60),
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(
                  'assets/avatar.jpg'), // Reemplaza con la ruta de tu imagen
            ),
            SizedBox(height: 16.0),

            // Información del Usuario (puedes personalizar según tus necesidades)
            Text(
              'Nombre de Usuario',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('usuario@example.com'),

            SizedBox(height: 32.0),

            // Lista Vertical de Opciones
            Column(
              children: [
                _buildListItem(Icons.notifications, 'Notificaciones', () {
                  _mostrarModal(
                      context, 'Notificaciones', 'Lista de notificaciones.');
                }),
                _buildListItem(Icons.exit_to_app, 'Cerrar Sesión', () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }),
                  );
                }),
                _buildListItem(Icons.delete, 'Borrar la Cuenta', () {
                  _mostrarModal(context, 'Borrar la Cuenta',
                      '¿Seguro que deseas borrar la cuenta?');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _mostrarModal(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el modal
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
