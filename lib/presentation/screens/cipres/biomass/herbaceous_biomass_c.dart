import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';

class HerbaceousBiomassC extends StatefulWidget {
  const HerbaceousBiomassC({super.key});

  @override
  State<HerbaceousBiomassC> createState() => _HerbaceousBiomassCState();
}

class _HerbaceousBiomassCState extends State<HerbaceousBiomassC> {
  StateBiomassC? stateBiomassC;
  String? errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassC = Provider.of<StateBiomassC>(context);
  }

  // Calculo de la biomasa herbacea
  void _calculateHerbaceousBiomassResult() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Resultado del cálculo',
                  style: TextStyle(fontSize: 18)),
              content: Text(
                'La biomasa herbácea es: ${stateBiomassC!.resultHerbaceousBiomassC.toStringAsFixed(2)} T/ha',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BiomassScreenC()));
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
                '¿Qué es la biomasa herbácea?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'La biomasa herbácea se refiere a la materia orgánica de las plantas herbáceas, que son plantas no leñosas como pastos, flores silvestres y otras plantas de bajo crecimiento. Estas plantas suelen ser de ciclo de vida corto y juegan un papel importante en los ecosistemas, proporcionando alimento para herbívoros, contribuyendo a la estabilidad del suelo y participando en los ciclos de nutrientes.',
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
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
                        'assets/img/cipres/biomass/biomass_c.jpg',
                        fit: BoxFit.fitWidth,
                        height: 259,
                      ),
                    ),

                    //Possition of the botton
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
                          )),
                    )
                  ]),

                  //Título
                  const SizedBox(height: 25.0),
                  const Text(
                    'Calculando la biomasa herbácea con Ciprés',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  //Formula
                  const SizedBox(height: 25.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 191, 192, 191)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'BH(T/ha) = ((PSM/PFM) * PFT) * 0.01',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  //NOTA
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*BH: Biomasa herbácea(T/ha) \n'
                          '*0.01: Factor de conversión para biomasa herbácea \n',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //Formula con variable completa
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Reemplazando valores:\n'
                        'BH(T/ha): (${stateBiomassC!.dryMatterCipres!.toStringAsFixed(2)} / ${stateBiomassC!.greenCipres!.toStringAsFixed(2)} * ${stateBiomassC!.greenCipres!.toStringAsFixed(2)} )\n '
                        ' * 0.01  ',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),

                  //Calcular
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
                        onPressed: _calculateHerbaceousBiomassResult,
                        child: const Text(
                          'Calcular',
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
      ),
    );
  }
}
