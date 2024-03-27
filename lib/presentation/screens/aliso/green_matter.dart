import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:version/presentation/screens/aliso/aliso_screen.dart';

class GreenMatterScreen extends StatefulWidget {
  const GreenMatterScreen({super.key});
  @override
  MyGreenMatterScreen createState() => MyGreenMatterScreen();
}

class MyGreenMatterScreen extends State<GreenMatterScreen> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/img/green_alder.jpg',
                  fit: BoxFit.fitWidth,
                  height: 259,
                ),
              ),

              //Título
              const SizedBox(height: 25.0),
              const Text(
                'Calculando la materia verde con Aliso',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //Día de evaluación
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Día de evaluación:',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    items: <String>['Día 30', 'Día 45', 'Día 60', 'Día 75']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              //Fecha actual
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Día de evaluación:   ${getFormattedDate()}',
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),

              //Peso de la materia verde
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Peso de la materia verde: ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 89,
                    height: 25,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Peso KG',
                        labelStyle: TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),

              //Guardar
              const SizedBox(height: 35.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: 240,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AlisoScreen()),
                      );
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }
}

/*
class GreenMatterScreen extends StatelessWidget {
  const GreenMatterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/img/green_alder.jpg',
                fit: BoxFit.fitWidth,
                height: 299,
              ),
            ),

            //Título
            const SizedBox(height: 20.0),
            const Text(
              'Calculando la materia verde con Aliso',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            //Materia verde
            const SizedBox(height: 20.0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                width: 240,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 51, 79, 31)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GreenMatterScreen()),
                    );
                  },
                  child: const Text(
                    'Guardar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
