import 'package:flutter/material.dart';

import 'package:version/presentation/screens/login/login_screen.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Esperar dos segundos antes de navegar a la siguiente pantalla
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ECO CARBON',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 9, 50, 125),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/img/lo_untrm.jpg',
              height: 160,
              width: 1600,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/igbi_blanco.jpg',
                  height: 110,
                  width: 80,
                ),
                const SizedBox(
                  width: 30,
                ),
                Image.asset(
                  'assets/img/fizab_negro.png',
                  height: 80,
                  width: 80,
                ),
              ],
            ),
            const SizedBox(
              height: 74,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 4, 72, 127)),
              strokeWidth: 3.5,
            ),
          ],
        ),
      ),
    );
  }
}
//Color.fromARGB(255, 82, 12, 7)