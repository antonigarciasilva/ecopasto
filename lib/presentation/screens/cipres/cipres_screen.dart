import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';
import 'package:version/presentation/screens/cipres/dry_matter_c.dart';
import 'package:version/presentation/screens/cipres/green_matter_c.dart';

import 'package:version/presentation/screens/widgets/side_menu.dart';

class CipresScreen extends StatefulWidget {
  const CipresScreen({super.key});

  @override
  State<CipresScreen> createState() => _CipresScreenState();
}

class _CipresScreenState extends State<CipresScreen> {
  //llamamos al provider
  StateBiomassC? stateCipres;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateCipres = Provider.of<StateBiomassC>(context);
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es el Ciprés?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: RichText(
                  textAlign: TextAlign.justify,
                  text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: 'Cupressus macrocarpa ',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                              ' se integra en cercos vivos dentro de las parcelas ganaderas, contribuyendo a la retención de carbono tanto en la biomasa como en el suelo. Los sistemas que incluyen Cupressus macrocarpa mostraron una alta eficiencia en la captura de carbono, lo que hace que estos sistemas sean valiosos para mejorar la calidad del suelo y mitigar el cambio climático​ \n'
                              '(Vásquez, 2023)',
                          style: TextStyle(fontSize: 14),
                        )
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
  void _showMissingCalculationsDialogC(
      BuildContext context, StateBiomassC stateCipres) {
    List<String> missingCalculationsC = [];

    if (!stateCipres.isGreenCipresCalculated) {
      missingCalculationsC.add('materia verde');
    }

    if (!stateCipres.isDryMatterCipresCalculated) {
      missingCalculationsC.add('materia seca');
    }

    String message =
        'Falta calcular: ${missingCalculationsC.join(', ')} para poder continuar';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
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

  @override
  Widget build(BuildContext context) {
    //responsive
    final size = MediaQuery.of(context).size;
    final stateCipres = Provider.of<StateBiomassC>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Silvopastoreo con Ciprés',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const SideMenu(),
      body: SafeArea(
          child: Stack(children: [
        //Imagen de fondo
        Positioned.fill(
            child: Image.asset(
          'assets/img/cipres/cipres_v.jpg',
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
                  'assets/img/untrm_white_png.png',
                  color: Colors.white.withOpacity(0.7),
                  height: size.height * 0.2,
                ),

                //Materia verde
                SizedBox(height: size.height * 0.03),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Stack(children: [
                    SizedBox(
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              stateCipres.isGreenCipresCalculated
                                  ? Colors.grey
                                  : const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: stateCipres.isGreenCipresCalculated
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GreenMatterC()),
                                );
                              },
                        child: const Text(
                          '1. Materia verde',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    if (stateCipres.isGreenCipresCalculated)
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GreenMatterC()));
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
                          backgroundColor: WidgetStateProperty.all<Color>(
                              stateCipres.isDryMatterCipresCalculated
                                  ? Colors.grey
                                  : const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: stateCipres.isDryMatterCipresCalculated
                            ? null
                            : () {
                                if (stateCipres.isGreenCipresCalculated) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DryMatterC()),
                                  );
                                } else {
                                  _showMissingCalculationsDialogC(
                                      context, stateCipres);
                                }
                              },
                        child: const Text(
                          '2. Materia seca',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    if (stateCipres.isDryMatterCipresCalculated)
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DryMatterC()));
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
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        if (stateCipres.isDryMatterCipresCalculated &&
                            stateCipres.isGreenCipresCalculated) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BiomassScreenC()),
                          );
                        } else {
                          _showMissingCalculationsDialogC(context, stateCipres);
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
                SizedBox(height: size.height * 0.03),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarbonScreenC()),
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
      ])),
    );
  }
}
