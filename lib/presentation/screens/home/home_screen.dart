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

    //Usamos MediaQuery para obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(children: <Widget>[
          Positioned.fill(
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
                child: Image.asset('assets/slides/silvipastoril.jpg',
                    fit: BoxFit.cover)),
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
                      height: size.height * 0.18,
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/fizab_blanco.png',
                          height: size.height * 0.1,
                          width: size.width * 0.3,
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Image.asset(
                          'assets/img/igbi_blanco_u.png',
                          height: size.height * 0.1,
                          width: size.width * 0.3,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
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
