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
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(children: <Widget>[
          Positioned.fill(
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
                child:
                    Image.asset('assets/img/pantalla.jpg', fit: BoxFit.cover)),
          ),
          Positioned(
              //Posición superior ajustada
              top: MediaQuery.of(context).size.height * 0.15,
              left: 0,
              right: 0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/logo_untrm_u.png',
                      height: 140,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/fizab_blanco.png',
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Image.asset(
                          'assets/img/igbi_blanco_u.png',
                          height: 130, //80 y 80
                          width: 115,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 251, 252, 252)),
                      strokeWidth: 2.5,
                    ),
                  ]))
        ]));
  }
}
