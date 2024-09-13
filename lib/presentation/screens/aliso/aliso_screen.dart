import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:version/presentation/screens/aliso/biomass/biomass.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';

import 'package:version/presentation/screens/aliso/carbon/carbon.dart';
import 'package:version/presentation/screens/aliso/dry_matter.dart';
import 'package:version/presentation/screens/aliso/green_matter.dart';

import 'package:version/presentation/screens/widgets/side_menu.dart';

class AlisoScreen extends StatefulWidget {
  const AlisoScreen({super.key});

  @override
  State<AlisoScreen> createState() => _AlisoScreenState();
}

class _AlisoScreenState extends State<AlisoScreen> {
  //Llamado de provider
  StateBiomass? stateBiomass;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomass = Provider.of<StateBiomass>(context);
  }

  //Dialogo para mostrar al usuario que le falta llenar algunos botones
  void _showMissingCalculationsDialog(
      BuildContext context, StateBiomass stateAliso) {
    List<String> missingCalculations = [];

    if (!stateAliso.isGreenSCalculated) {
      missingCalculations.add('materia verde');
    }

    if (!stateAliso.isDryMatterSCalculated) {
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

  //Dialogo informativo sobre el Aliso
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es el Aliso?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Alnus acuminata',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                        text:
                            ' en sistemas silvopastoriles es una especie arbórea utilizada por sus beneficios ambientales y productivos. Proporciona sombra, mejora la calidad del suelo y puede utilizarse como fuente de alimento y forraje para animales en sistemas agroforestales.',
                      )
                    ]),
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
    final stateAliso = Provider.of<StateBiomass>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Silvopastoreo con Aliso',
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;

            return Stack(
              children: [
                //Imagen de fondo
                Positioned.fill(
                    child: Image.asset(
                  'assets/img/aliso/aliso_verde.jpg',
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                )),

                //Contenido principal
                Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Logo de la app
                        Image.asset(
                          'assets/img/only_logo.png',
                          height: screenHeight * 0.2,
                        ),

                        SizedBox(
                          height: screenHeight * 0.02,
                        ),

                        //Materia verde
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Stack(children: [
                            SizedBox(
                              width: screenWidth * 0.6,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          stateAliso.isGreenSCalculated
                                              ? Colors.grey
                                              : const Color.fromARGB(
                                                  255, 51, 79, 31)),
                                ),
                                onPressed: stateAliso.isGreenSCalculated
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const GreenMatterScreen()),
                                        );
                                      },
                                child: const Text(
                                  '1. Materia verde',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            if (stateAliso.isGreenSCalculated)
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const GreenMatterScreen()));
                                  },
                                  icon: const Icon(Icons.edit))
                          ]),
                        ),

                        //Materia seca
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Stack(children: [
                            SizedBox(
                              width: screenWidth * 0.6,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          stateAliso.isDryMatterSCalculated
                                              ? Colors.grey
                                              : const Color.fromARGB(
                                                  255, 51, 79, 31)),
                                ),
                                onPressed: stateAliso.isDryMatterSCalculated
                                    ? null
                                    : () {
                                        if (stateAliso.isGreenSCalculated) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DryMatterScreen()),
                                          );
                                        } else {
                                          _showMissingCalculationsDialog(
                                              context, stateAliso);
                                        }
                                      },
                                child: const Text(
                                  '2. Materia seca',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            if (stateAliso.isDryMatterSCalculated)
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DryMatterScreen()));
                                  },
                                  icon: const Icon(Icons.edit))
                          ]),
                        ),

                        //Biomasa
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            width: screenWidth * 0.6,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 51, 79, 31)),
                              ),
                              onPressed: () {
                                if (stateAliso.isDryMatterSCalculated &&
                                    stateAliso.isGreenSCalculated) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BiomassAlderScreen()),
                                  );
                                } else {
                                  _showMissingCalculationsDialog(
                                      context, stateAliso);
                                }
                              },
                              child: const Text(
                                ' 3. Biomasa',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        //Carbono en la biomasa
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            width: screenWidth * 0.6,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 51, 79, 31)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CarbonScreen()),
                                );
                              },
                              child: const Text(
                                '4. Carbono en la biomasa',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //Botón informativo

                Positioned(
                  top: screenHeight * 0.02,
                  right: screenWidth * 0.05,
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
