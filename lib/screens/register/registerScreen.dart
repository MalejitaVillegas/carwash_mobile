import 'package:carwash/screens/login/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../tabbar/tabbar.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<registerScreen> {
  String _email = "";
  String _psassword = "";
  String _name = "";

  Future<void> createUser(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      User? user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(_name);
      var users = FirebaseFirestore.instance.collection("users");
      users
          .add({
            'full_name': _name,
            'email': _email,
            'uid': credential.user?.uid ?? "",
          })
          .then((value) => // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Tabbar();
                }),
              ))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/imagenlavado.jpg',
              fit: BoxFit.cover,
              height: 310,
              width: double.infinity,
            ),
            Image.asset(
              "assets/images/mask.png",
              fit: BoxFit.cover,
              height: 310,
              width: double.infinity,
            ),
            Container(
              margin: const EdgeInsets.only(top: 250),
              decoration: const BoxDecoration(
                color: Colors.white, // Color de fondo del container
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: form(),
            )
          ],
        ),
      ),
    );
  }

  Widget form() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onChanged: (data) {
                _name = data;
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onChanged: (data) {
                _email = data;
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onChanged: (data) {
                _psassword = data;
              },
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                createUser(_email, _psassword);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 50.0),
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: RichText(
                text: const TextSpan(
                  text: "Already have account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'LOGIN',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
