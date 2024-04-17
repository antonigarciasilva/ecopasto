import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/biomass/biomass.dart';

class HerbaceousBiomassScreen extends StatelessWidget {
  const HerbaceousBiomassScreen({super.key});

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
                  'Calculando la biomasa herbácea con Aliso',
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
                    width: 320,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'BH(t/ha) = ((PSM/PFM) * PFT) * 0.01',
                        style: TextStyle(fontSize: 16, color: Colors.white),
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

                //PSM
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'PSM: ',
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
                          labelText: 'g',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),

                //PFM
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'PFM: ',
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
                          labelText: 'g',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),

                //PST
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'PST: ',
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
                          labelText: 'g',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),

                //NOTA
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nota: \n'
                        '*BH: Biomasa herbácea(t/ha) \n'
                        '*PSM: Peso seco de la materia recolectada (g)\n'
                        '*PFM: Peso fresco de la muestra colectada (g) \n'
                        '*PFT: Peso fresco total por metro cuadrado (g/m2) \n'
                        '*0.01: Factor de conversión para biomasa herbácea \n',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
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
