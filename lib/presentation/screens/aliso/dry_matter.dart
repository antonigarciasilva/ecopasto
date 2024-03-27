import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/aliso_screen.dart';

class DryMatterScreen extends StatefulWidget {
  const DryMatterScreen({super.key});
  @override
  MyGreenMatterScreen createState() => MyGreenMatterScreen();
}

class MyGreenMatterScreen extends State<DryMatterScreen> {
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
                  'assets/img/dry_alder.jpg',
                  fit: BoxFit.fitWidth,
                  height: 259,
                ),
              ),

              //Título
              const SizedBox(height: 25.0),
              const Text(
                'Calculando la materia seca con Aliso',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //Formula
              const SizedBox(height: 25.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: 240,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'MS/M2 = PMS/PMH x 100',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),

              //Día de evaluación
              const SizedBox(height: 25.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Día de evaluación: ',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  SizedBox(width: 20),
                ],
              ),

              //Peso de la materia verde
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Peso de la materia seca: ',
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
                        labelText: 'Peso g',
                        labelStyle: TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),

              //Peso de la materia húmeda
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Peso de la materia húmeda: ',
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
                        labelText: 'Peso g',
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
                      'Calcular',
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
}
