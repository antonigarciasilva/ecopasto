import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/no_tree/result_st.dart';

import 'package:version/presentation/screens/no_tree/state_s.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';

class HerbaceousBiomassST extends StatefulWidget {
  const HerbaceousBiomassST({super.key});

  @override
  State<HerbaceousBiomassST> createState() => _HerbaceousBiomassSTState();
}

class _HerbaceousBiomassSTState extends State<HerbaceousBiomassST> {
  StateBiomass? stateBiomass;
  StateBiomassC? stateBiomassC;
  StateBiomassP? stateBiomassP;
  StateBiomassO? stateBiomassO;
  StateST? stateST;
  String? errorMessage;

  //Para usar el provider
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomass = Provider.of<StateBiomass>(context);
    stateBiomassC = Provider.of<StateBiomassC>(context);
    stateBiomassP = Provider.of<StateBiomassP>(context);
    stateBiomassO = Provider.of<StateBiomassO>(context);
    stateST = Provider.of<StateST>(context);
  }

  void _seeResultCarbonST() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultSt(
                  //Aliso
                  resultCarbonBiomass: stateBiomass!.resultCarbonBiomass,
                  totalBiomass: stateBiomass!.totalBiomass,
                  resultConversionCarbon: stateBiomass!.resultConversionCarbon,
                  sumaTotal: stateBiomass!.sumaTotal,
                  //Ciprés
                  resultCarbonBiomassC: stateBiomassC!.resultCarbonBiomassC,
                  totalBiomassC: stateBiomassC!.totalBiomassC,
                  resultConversionCarbonC:
                      stateBiomassC!.resultConversionCarbonC,
                  sumaTotalC: stateBiomassC!.sumaTotalC,
                  //Pona
                  resultCarbonBiomassO: stateBiomassO!.resultCarbonBiomassO,
                  totalBiomassO: stateBiomassO!.totalBiomassO,
                  resultConversionCarbonO:
                      stateBiomassO!.resultConversionCarbonO,
                  sumaTotalO: stateBiomassO!.sumaTotalO,
                  //SSA
                  resultCarbonBiomassST: stateST!.resultCarbonBiomassST,
                  resultHerbaceousBiomassST: stateST!.resultHerbaceousBiomassST,
                  resultConversionCarbonST: stateST!.resultConversionCarbonST,
                  sumaTotalST: stateST!.sumaTotalST,
                  //Pino
                  resultCarbonBiomassP: stateBiomassP!.resultCarbonBiomassP,
                  totalBiomassP: stateBiomassP!.totalBiomassP,
                  resultConversionCarbonP:
                      stateBiomassP!.resultConversionCarbonP,
                  sumaTotalP: stateBiomassP!.sumaTotalP,
                )));
  }

//Calculamos el carbon con la biomasa
  void _calculateBiomassCarbonResult() {
    if (stateST?.resultHerbaceousBiomassST == 0.00) {
      setState(() {
        errorMessage =
            'Por favor, completa el modulo de biomasa para calcular el carbono';
      });
    } else {
      setState(() {
        errorMessage = null;
      });
      _seeResultCarbonST();
    }
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'La biomasa herbácea se refiere a la materia orgánica de las plantas herbáceas, que son plantas no leñosas como pastos, flores silvestres y otras plantas de bajo crecimiento. Estas plantas suelen ser de ciclo de vida corto y juegan un papel importante en los ecosistemas, proporcionando alimento para herbívoros, contribuyendo a la estabilidad del suelo y participando en los ciclos de nutrientes.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    //responsive
    final size = MediaQuery.of(context).size;
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
                        'assets/img/sinarbol/biomass/biomass_s.png',
                        fit: BoxFit.fitHeight,
                        height: size.height * 0.55,
                      ),
                    ),
                    //Possition of the botton
                    Positioned(
                      top: size.height * 0.05,
                      right: size.width * 0.01,
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
                  SizedBox(height: size.height * 0.03),
                  const Text(
                    'Calculando la biomasa herbácea en un pastizal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Formula
                  SizedBox(height: size.height * 0.03),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: size.width * 0.95,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'BH(T/ha) = ((PSM/PFM) * PFT) * 0.01',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //NOTA
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                      ),
                      child: const Align(
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
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Reemplazando valores:\n'
                        'BH(T/ha): (${stateST!.dryMatterS!.toStringAsFixed(2)} / ${stateST!.greenS!.toStringAsFixed(2)} * ${stateST!.greenS!.toStringAsFixed(2)} )\n '
                        ' * 0.01  ',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  //Calcular
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
                        onPressed: () async {
                          if (stateST!.areAllCalculationsCompletedS) {
                            _calculateBiomassCarbonResult();
                          }
                          //Guardar los datos en Firestore después de calcular
                          try {
                            //Obtener la ubicación antes de guardar
                            await stateST!.getCurrentLocation();
                            //Guardamos en Firestore después de calcular y obtener la ubicación
                            await stateST!.saveToFirestore();
                            //Para verificar si el widget aún esta montado
                            if (mounted) return;
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Datos guardados satisfactoriamente!')));
                          } catch (e) {
                            if (!mounted) return;
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Error al guardar datos: $e')));
                          }
                        },
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
