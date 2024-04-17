import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/biomass/biomass.dart';

class DryBiomassScreen extends StatelessWidget {
  const DryBiomassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/img/biomas_alder.jpg',
                    fit: BoxFit.fitWidth,
                    height: 259,
                  ),
                ),

                //Título
                const SizedBox(height: 25.0),
                const Text(
                  'Calculando la biomasa seca con Aliso',
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
                    width: 250,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 191, 192, 191)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'C = -22.695 + 1.5085 * DAP',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),

                //NOTA
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*DAP: Diámetro a la altura del pecho',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
                //Día de evaluación
                const SizedBox(height: 20.0),
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

                //DAP
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'DAP: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 79,
                      height: 25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CM',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),

                //Guardar
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
                              builder: (context) => const BiomassAlderScreen()),
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
      ),
    );
  }
}
