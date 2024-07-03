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
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'Un pastizal es una extensión de tierra cubierta predominantemente por pastos y otras plantas herbáceas, utilizada principalmente para el pastoreo de ganado.',
                textAlign: TextAlign.justify,
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

  @override
  Widget build(BuildContext context) {
    final stateS = Provider.of<StateST>(context);
    return Scaffold(
      appBar: AppBar(
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
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Botón informativo
                Stack(children: [
                  //imagen de la pantalla
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/sinarbol/biomass/biomass_s.png',
                      fit: BoxFit.fitWidth,
                      height: 299,
                    ),
                  ),

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
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 260,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            stateS.isGreenSCalculated
                                ? Colors.grey
                                : const Color.fromARGB(255, 51, 79, 31)),
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
                            stateS.isDryMatterSCalculated
                                ? Colors.grey
                                : const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: stateS.isDryMatterSCalculated
                          ? null
                          : () {
                              if (stateS.isGreenSCalculated) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DryMatterS()),
                                );
                              }
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
                        if (stateS.isDryMatterSCalculated &&
                            stateS.isGreenSCalculated) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HerbaceousBiomassST()),
                          );
                        }
                      },
                      child: const Text(
                        ' 3. Biomasa Herbacea',
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
