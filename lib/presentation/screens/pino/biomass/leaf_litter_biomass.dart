import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pino/biomass/biomass.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';

class LeafLitterBiomassP extends StatefulWidget {
  const LeafLitterBiomassP({super.key});

  @override
  State<LeafLitterBiomassP> createState() => _LeafLitterBiomassPState();
}

class _LeafLitterBiomassPState extends State<LeafLitterBiomassP> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightPSM = TextEditingController();
  final TextEditingController _controllerWeightPFM = TextEditingController();

  //Validación de peso
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }
    //Validación con regex
    final weightRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Solo se acepta valores numéricos';
    }
    return null;
  }

  // Calculo de la biomasa hojarasca

  void _calculateLeafLitterBiomassResult() {
    if (_formKey.currentState!.validate()) {
      final double psm = double.parse(_controllerWeightPSM.text);
      final double pfm = double.parse(_controllerWeightPFM.text);

      final double resulthba = (psm / pfm * pfm) * 0.04;
      final String formattedResult = resulthba.toStringAsFixed(2);

      Provider.of<StateBiomassP>(context, listen: false)
          .setLeafLitterBiomassP(resulthba);
      Provider.of<StateBiomassP>(context, listen: false).setPfmP(pfm);
      Provider.of<StateBiomassP>(context, listen: false).setPsmP(psm);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Text(
                  'Resultado del cálculo',
                  style: TextStyle(fontSize: 18),
                ),
                content: Text(
                  'La biomasa herbácea es: $formattedResult T/ha',
                  textAlign: TextAlign.justify,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BiomassPinoScreen()));
                      },
                      child: const Text('Aceptar'))
                ],
              ));
    }
  }

  //Dialogo informativo sobre la biomasa
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es la biomasa hojarasca?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'La biomasa de hojarasca incluye las hojas caídas, ramas pequeñas, flores, frutos y otros restos vegetales que se acumulan en el suelo del bosque o de cualquier área con vegetación arbórea. Esta hojarasca es una fuente crucial de nutrientes para el suelo, ya que se descompone y enriquece el suelo con materia orgánica, mejorando su estructura y fertilidad.',
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
    //responsive
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                        'assets/img/pino/biomass/biomass.jpg',
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
                    'Calculando la biomasa hojarasca con Pino',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
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
                          'BH(T/ha) = ((PSM/PFM) * PFT) * 0.04',
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
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*BH: Biomasa hojarasca(T/ha) \n'
                          '*0.04: Factor de conversión para biomasa hojarasca \n',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //PSM
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Peso seco de la materia (PSM): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.15),
                    child: TextFormField(
                      controller: _controllerWeightPSM,
                      validator: _validateWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Ingresa el peso en gr',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //PFM
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Peso fresco de la muestra (PFM): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.15),
                    child: TextFormField(
                      controller: _controllerWeightPFM,
                      validator: _validateWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Ingresa el peso en gr',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                        onPressed: _calculateLeafLitterBiomassResult,
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
