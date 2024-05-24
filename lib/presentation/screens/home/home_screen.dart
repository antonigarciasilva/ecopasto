import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 12, 7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/img/igbisvg.svg',
              height: 160,
              width: 1600,
            ),
            const SizedBox(
              height: 74,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}

/*     home: Scaffold(
       
  }
}
*/
