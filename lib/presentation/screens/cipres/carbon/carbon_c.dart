import 'package:flutter/material.dart';
import 'package:version/presentation/screens/cipres/carbon/biomass_carbon_c.dart';
import 'package:version/presentation/screens/cipres/carbon/conversion_carbon_c.dart';
import 'package:version/presentation/screens/cipres/carbon/soil_carbon_c.dart';

class CarbonScreenC extends StatelessWidget {
  const CarbonScreenC({super.key});

  //Dialogo informativo para carbono

  void openDialog(BuildContext context) {
    showDialog(
        context: context,

        //para no poder salir del dialogo al hacer caulquier click
        barrierDismissible: false,
        builder: (context) => AlertDialog(
                title: const Text(
                  '¿Qué es el carbono?',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
                content: const Text(
                  'El carbono en los sistemas silvopastoriles se almacena en la biomasa de árboles y pastos, en el suelo y en los residuos animales, desempeñando un papel crucial en la captura de CO₂ y la mitigación del cambio climático. Estos sistemas integrados mejoran la fertilidad del suelo, aumentan su capacidad de retención de agua y nutrientes, y promueven la resiliencia ecológica. ',
                  textAlign: TextAlign.justify,
                ),
                actions: [
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Aceptar'))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/cipres/carbon/carbon_c.png',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),

                  //Posición del boton informátivo
                  Positioned(
                    right: 5,
                    top: 50,
                    child: FilledButton.tonal(
                      onPressed: () => openDialog(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),

                //Título
                const SizedBox(height: 25.0),
                const Text(
                  'Calculando carbono en la biomasa con Ciprés',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                //Carbono en biomasa
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BiomassCarbonC()),
                        );
                      },
                      child: const Text(
                        'Carbono en biomasa',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Carbono en el suelo
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SoilCarbonC()),
                        );
                      },
                      child: const Text(
                        'Carbono en el suelo',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Conversión de carbono a dióxido de carbono
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ConversionCarbonC()),
                        );
                      },
                      child: const Text(
                        'Conversión de C a CO₂',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //NOTA

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '*C: Carbono \n'
                      '*CO₂: Dióxido de carbono \n',
                      style: TextStyle(fontSize: 10),
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
