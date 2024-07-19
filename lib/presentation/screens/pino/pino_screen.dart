import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:version/presentation/screens/pino/biomass/biomass.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';
import 'package:version/presentation/screens/pino/carbon/carbon.dart';
import 'package:version/presentation/screens/pino/dry_matter_p.dart';
import 'package:version/presentation/screens/pino/green_matter_p.dart';

import 'package:version/presentation/screens/widgets/side_menu.dart';

class PinoScreen extends StatefulWidget {
  const PinoScreen({super.key});

  @override
  State<PinoScreen> createState() => _PinoScreenState();
}

class _PinoScreenState extends State<PinoScreen> {
  //Llamamos al provider
  StateBiomassP? statePino;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    statePino = Provider.of<StateBiomassP>(context);
  }

  //Funcion de boton informativo
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es el Pino?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: RichText(
                  textAlign: TextAlign.justify,
                  text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'Pinus sylvestris',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                ' en sistemas silvopastoriles es una especie de árbol conífero ampliamente utilizada por su madera, resina y otros productos forestales. En sistemas silvopastoriles, el pino proporciona sombra, protección contra el viento y mejora la calidad del suelo. Además, puede ser utilizado como fuente de alimento y forraje para animales en sistemas agroforestales.')
                      ])),
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

  //Dialogo para mostrar al usuario que le falta llenar algunos botones
  void _showMissingCalculationsDialogP(
      BuildContext context, StateBiomassP statePino) {
    List<String> missingCalculationsP = [];

    if (!statePino.isGreenPinoCalculated) {
      missingCalculationsP.add('materia verde');
    }

    if (!statePino.isDryMatterPinoCalculated) {
      missingCalculationsP.add('materia seca');
    }

    String message =
        'Falta calcular: ${missingCalculationsP.join(', ')} para poder continuar';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                'Calculos imcompletos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              content: Text(
                message,
                textAlign: TextAlign.justify,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final statePino = Provider.of<StateBiomassP>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Silvopastoreo con Pino',
          style: TextStyle(
            fontSize: 18,
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
                      'assets/img/pino/pino.jpg',
                      fit: BoxFit.fitWidth,
                      height: 299,
                    ),
                  ),

                  //Posición del botton
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
                  child: Stack(children: [
                    SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              statePino.isGreenPinoCalculated
                                  ? Colors.grey
                                  : const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: statePino.isGreenPinoCalculated
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GreenMatterP()),
                                );
                              },
                        child: const Text(
                          '1. Materia verde',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    if (statePino.isGreenPinoCalculated)
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GreenMatterP()));
                          },
                          icon: const Icon(Icons.edit))
                  ]),
                ),

                //Materia seca
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Stack(children: [
                    SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              statePino.isDryMatterPinoCalculated
                                  ? Colors.grey
                                  : const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: statePino.isDryMatterPinoCalculated
                            ? null
                            : () {
                                if (statePino.isGreenPinoCalculated) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DryMatterP()),
                                  );
                                } else {
                                  _showMissingCalculationsDialogP(
                                      context, statePino);
                                }
                              },
                        child: const Text(
                          '2. Materia seca',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    if (statePino.isDryMatterPinoCalculated)
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DryMatterP()));
                          },
                          icon: const Icon(Icons.edit))
                  ]),
                ),

                //Biomasa
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
                        if (statePino.isDryMatterPinoCalculated &&
                            statePino.isGreenPinoCalculated) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BiomassPinoScreen()),
                          );
                        } else {
                          _showMissingCalculationsDialogP(context, statePino);
                        }
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
                              builder: (context) => const CarbonPinoScreen()),
                        );
                      },
                      child: const Text(
                        '4. Carbono en la biomasa',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
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
