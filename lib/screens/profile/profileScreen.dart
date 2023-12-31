import 'package:carwash/screens/login/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<profileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  late XFile _imageFile; // Para almacenar la imagen seleccionada

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _imageFile = XFile('');
  }

  // Método para seleccionar una imagen de la galería
  Future<void> _selectImage() async {
    await _requestGalleryPermission();
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
      _uploadImage();
    }
  }

  // Función para solicitar permisos de galería
  Future<void> _requestGalleryPermission() async {
    var status = await Permission.photos.status;

    if (status.isDenied) {
      // Solicitar permisos
      await Permission.photos.request();
    }
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
        title: Text('Mi Perfil'),
      ),
      body: Center(
        child: Column(
          children: [
            // Avatar
            SizedBox(height: 60),
            InkWell(
              onTap: _selectImage,
              child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage:
                      _getImageProvider() // Imagen predeterminada si no hay ninguna seleccionada
                  ),
            ),
            SizedBox(height: 16.0),

            // Información del Usuario (puedes personalizar según tus necesidades)
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? "",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(FirebaseAuth.instance.currentUser?.email ?? ""),

            SizedBox(height: 32.0),

            // Lista Vertical de Opciones
            Column(
              children: [
                _buildListItem(Icons.notifications, 'Notificaciones', () {
                  _mostrarModal(
                      context, 'Notificaciones', 'Lista de notificaciones.');
                }),
                _buildListItem(Icons.exit_to_app, 'Cerrar Sesión', () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }),
                          ));
                  ;
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

  ImageProvider<Object>? _getImageProvider() {
    if (_imageFile.path.isNotEmpty) {
      return FileImage(File(_imageFile.path));
    } else {
      String? photoURL = FirebaseAuth.instance.currentUser?.photoURL;
      return photoURL != null ? NetworkImage(photoURL) : null;
    }
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

  Future<void> _uploadImage() async {
    if (_auth.currentUser == null) {
      // No hay usuario autenticado
      return;
    }

    try {
      final String userId = _auth.currentUser!.uid;

      // Sube la imagen a Firebase Storage
      final Reference storageRef =
          _storage.ref().child('user_images/$userId.jpg');
      await storageRef.putFile(File(_imageFile.path));
      final String imageUrl = await storageRef.getDownloadURL();
      await _auth.currentUser!.updatePhotoURL(imageUrl);
      await _auth.currentUser!.reload();
      await _auth.currentUser!.getIdToken(true);

      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Imagen subida con éxito')));
    } catch (error) {
      print('Error al subir la imagen: $error');
    }
  }
}
