import 'package:carwash/screens/home/homeScreen.dart';
import 'package:carwash/screens/notifications/notificationScreen.dart';
import 'package:carwash/screens/profile/profileScreen.dart';
import 'package:flutter/material.dart';

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _currentIndex = 0;

  // Lista de widgets que representan las páginas correspondientes a cada índice
  final List<Widget> _paginas = [
    homeScreen(),
    NotificationScreen(),
    profileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class servicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Página de servicios'),
    );
  }
}
