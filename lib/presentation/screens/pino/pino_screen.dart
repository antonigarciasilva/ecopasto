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
              backgroundColor: Colors.white,
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
              backgroundColor: Colors.white,
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
    //responsive
    final size = MediaQuery.of(context).size;
    final statePino = Provider.of<StateBiomassP>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Silvopastoreo con Pino',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const SideMenu(),
      body: SafeArea(
        child: Stack(
          children: [
            // Imagen de fondo
            Positioned.fill(
              child: Image.asset(
                'assets/img/pino/pinos.jpg',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.0),
                colorBlendMode: BlendMode.darken,
              ),
            ),

            // Contenido principal
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Logo de la app
                    SizedBox(height: size.height * 0.03),
                    Image.asset(
                      'assets/img/untrm_white_png.png',
                      color: Colors.white.withOpacity(0.7),
                      height: size.height * 0.2,
                    ),

                    SizedBox(height: size.height * 0.05),

                    // Materia verde

                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: size.width * 0.8,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  statePino.isGreenPinoCalculated
                                      ? Colors.grey
                                      : const Color.fromARGB(255, 51, 79, 31),
                                ),
                              ),
                              onPressed: statePino.isGreenPinoCalculated
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const GreenMatterP(),
                                        ),
                                      );
                                    },
                              child: const Text(
                                '1. Materia verde',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          if (statePino.isGreenPinoCalculated)
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GreenMatterP(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                        ],
                      ),
                    ),

                    // Materia seca
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: size.width * 0.8,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  statePino.isDryMatterPinoCalculated
                                      ? Colors.grey
                                      : const Color.fromARGB(255, 51, 79, 31),
                                ),
                              ),
                              onPressed: statePino.isDryMatterPinoCalculated
                                  ? null
                                  : () {
                                      if (statePino.isGreenPinoCalculated) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DryMatterP(),
                                          ),
                                        );
                                      } else {
                                        _showMissingCalculationsDialogP(
                                            context, statePino);
                                      }
                                    },
                              child: const Text(
                                '2. Materia seca',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          if (statePino.isDryMatterPinoCalculated)
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DryMatterP(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                        ],
                      ),
                    ),

                    // Biomasa
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: size.width * 0.8,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31),
                            ),
                          ),
                          onPressed: () {
                            if (statePino.isDryMatterPinoCalculated &&
                                statePino.isGreenPinoCalculated) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BiomassPinoScreen(),
                                ),
                              );
                            } else {
                              _showMissingCalculationsDialogP(
                                  context, statePino);
                            }
                          },
                          child: const Text(
                            '3. Biomasa',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // Carbono en la biomasa
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: size.width * 0.8,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CarbonPinoScreen(),
                              ),
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
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ),

            //Botón informativo

            Positioned(
              top: size.height * 0.03,
              right: size.width * 0.01,
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
            )
          ],
        ),
      ),
    );
  }
}
