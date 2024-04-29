import 'package:flutter/material.dart';

class CipresScreen extends StatelessWidget {
  const CipresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/img/cipres/cypress.jpg',
              height: 30,
            ),
            const SizedBox(
              width: 10,
              height: 15,
            ),
            const Text(
              'Silvipastoreo con Pino',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
