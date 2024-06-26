import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:version/presentation/screens/pona/biomass/biomass_pona.dart';
import 'package:version/presentation/screens/pona/carbon/carbon_pona.dart';
import 'package:version/presentation/screens/pona/dry_pona.dart';
import 'package:version/presentation/screens/pona/green_matter.dart';
import 'package:version/presentation/screens/pona/state_pona.dart';
import 'package:version/presentation/screens/widgets/side_menu.dart';

class PonaScreen extends StatefulWidget {
  const PonaScreen({super.key});

  @override
  State<PonaScreen> createState() => _PonaScreenState();
}

class _PonaScreenState extends State<PonaScreen> {
  //Llamamos al provider
  StatePona? statePona;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    statePona = Provider.of<StatePona>(context);
  }

  //Funcion de boton informativo
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es la Pona?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'El árbol de la pona (Calycophyllum spruceanum) en sistemas silvopastoriles es una especie arbórea nativa de la Amazonía utilizada por su rápido crecimiento y capacidad para mejorar la calidad del suelo. Proporciona sombra y protección contra el viento, y también puede utilizarse como fuente de alimento y forraje para animales en sistemas agroforestales.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final statePona = Provider.of<StatePona>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Silvopastoreo con Pona',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const SideMenu(),
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
                      'assets/img/pona/pona.jpg',
                      fit: BoxFit.fitWidth,
                      height: 299,
                    ),
                  ),

                  //Position of the buttom
                  Positioned(
                    right: 5,
                    top: 50,
                    child: FilledButton.tonal(
                      onPressed: () => openDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),

                //Materia verde
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 260,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            statePona.isGreenPonaCalculated
                                ? Colors.grey
                                : const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: statePona.isGreenPonaCalculated
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GreenMatterPona()),
                              );
                            },
                      child: const Text(
                        '1. Materia verde',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Materia seca
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 260,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            statePona.isDryMatterPonaCalculated
                                ? Colors.grey
                                : const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: statePona.isDryMatterPonaCalculated
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DryPonaScreen()),
                              );
                            },
                      child: const Text(
                        '2. Materia seca',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Biomasa
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 260,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BiomassPona()),
                        );
                      },
                      child: const Text(
                        ' 3. Biomasa',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Carbono en la biomasa
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 260,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarbonPonaScreen()),
                        );
                      },
                      child: const Text(
                        '4. Carbono en la biomasa',
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
