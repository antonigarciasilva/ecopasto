import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:version/presentation/screens/no_tree/biomass/herbaceous_biomass_s.dart';

import 'package:version/presentation/screens/no_tree/dry_matter_s.dart';
import 'package:version/presentation/screens/no_tree/green_matter_s.dart';
import 'package:version/presentation/screens/no_tree/state_s.dart';

import 'package:version/presentation/screens/widgets/side_menu.dart';

class NoTreeScreen extends StatefulWidget {
  const NoTreeScreen({super.key});

  @override
  State<NoTreeScreen> createState() => _NoTreeScreenState();
}

class _NoTreeScreenState extends State<NoTreeScreen> {
  //Dialogo informativo sobre el pastizal
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es un pastizal?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Un pastizal es una extensión de tierra cubierta predominantemente por pastos y otras plantas herbáceas, utilizada principalmente para el pastoreo de ganado.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  //Método para alerta cuando te falta llenar los datos
  void _showMissingCalculationDialog(BuildContext context, StateST stateSt) {
    List<String> missingCalculations = [];

    if (!stateSt.isGreenSCalculated) {
      missingCalculations.add('materia verde');
    }
    if (!stateSt.isDryMatterSCalculated) {
      missingCalculations.add('materia seca');
    }

    String message =
        'Falta calcular: ${missingCalculations.join(', ')} para poder continuar';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Cálculos imcompletos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                message,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 14),
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
    final stateS = Provider.of<StateST>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Sistema sin arboles',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const SideMenu(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                //Imagen de fondo
                Positioned.fill(
                    child: Image.asset(
                  'assets/img/sinarbol/sin_pasto.jpg',
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                )),

                //Contenido principal
                Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Logo de la app
                          Image.asset(
                            'assets/img/untrm_white_png.png',
                            color: Colors.white.withOpacity(0.7),
                            height: size.height * 0.2,
                          ),

                          SizedBox(height: size.height * 0.03),
                          //Materia verde
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Stack(children: [
                              SizedBox(
                                width: size.width * 0.8,
                                //Ajuste de ancho relativo
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            stateS.isGreenSCalculated
                                                ? Colors.grey
                                                : const Color.fromARGB(
                                                    255, 51, 79, 31)),
                                  ),
                                  onPressed: stateS.isGreenSCalculated
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const GreenMatterScreenS()),
                                          );
                                        },
                                  child: const Text(
                                    '1. Materia verde',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              if (stateS.isGreenSCalculated)
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const GreenMatterScreenS()));
                                    },
                                    icon: const Icon(Icons.edit))
                            ]),
                          ),

                          //Materia seca
                          SizedBox(height: size.height * 0.03),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Stack(children: [
                              SizedBox(
                                width: size.width * 0.8,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            stateS.isDryMatterSCalculated
                                                ? Colors.grey
                                                : const Color.fromARGB(
                                                    255, 51, 79, 31)),
                                  ),
                                  onPressed: stateS.isDryMatterSCalculated
                                      ? null
                                      : () {
                                          if (stateS.isGreenSCalculated) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DryMatterS()),
                                            );
                                          } else {
                                            _showMissingCalculationDialog(
                                                context, StateST());
                                          }
                                        },
                                  child: const Text(
                                    '2. Materia seca',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              if (stateS.isDryMatterSCalculated)
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DryMatterS()));
                                    },
                                    icon: const Icon(Icons.edit))
                            ]),
                          ),

                          //Biomasa
                          SizedBox(height: size.height * 0.03),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: SizedBox(
                              width: size.width * 0.8,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 51, 79, 31)),
                                ),
                                onPressed: () {
                                  if (stateS.isDryMatterSCalculated &&
                                      stateS.isGreenSCalculated) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HerbaceousBiomassST()),
                                    );
                                  } else {
                                    _showMissingCalculationDialog(
                                        context, StateST());
                                  }
                                },
                                child: const Text(
                                  ' 3. Biomasa Herbacea',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Botón informativo

                Positioned(
                  top: size.height * 0.05,
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
            );
          },
        ),
      ),
    );
  }
}
