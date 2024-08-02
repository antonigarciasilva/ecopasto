import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';

class LeafLitterBiomassC extends StatefulWidget {
  const LeafLitterBiomassC({super.key});

  @override
  State<LeafLitterBiomassC> createState() => _LeafLitterBiomassCState();
}

class _LeafLitterBiomassCState extends State<LeafLitterBiomassC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightPSM = TextEditingController();
  final TextEditingController _controllerWeightPFM = TextEditingController();
  final TextEditingController _controllerWeightPST = TextEditingController();

  //Validación del peso
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }
    //Validación de peso
    final weightRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Solo se acepta valores númericos';
    }
    return null;
  }

  // Calculo de la biomasa hojarasca

  void _calculateLeafLitterBiomassResult() {
    if (_formKey.currentState!.validate()) {
      final double psm = double.parse(_controllerWeightPSM.text);
      final double pfm = double.parse(_controllerWeightPFM.text);
      final double pst = double.parse(_controllerWeightPST.text);

      final double leafLitterBiomassC = (psm / pfm * pst) * 0.04;
      final String formattedResult = leafLitterBiomassC.toStringAsFixed(2);

      Provider.of<StateBiomassC>(context, listen: false)
          .setLeafLitterBiomassC(leafLitterBiomassC);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
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
                                builder: (context) => const BiomassScreenC()));
                      },
                      child: const Text('Aceptar'))
                ],
              ));
    }
  }

  //Dialogo informativo sobre el Aliso
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
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
                    'Calculando la biomasa hojarasca con Ciprés',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
                          'BH(T/ha) = ((PSM/PFM) * PFT) * 0.04',
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
                          '*BH: Biomasa hojarasca(Tm/ha) \n'
                          '*0.04: Factor de conversión para biomasa hojarasca \n',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //PSM
                  const SizedBox(height: 25),

                  const Text(
                    'Peso seco de la materia (PSM): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
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
                  const SizedBox(height: 25),

                  const Text(
                    'Peso fresco de la muestra (PFM): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
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

                  //PST
                  const SizedBox(height: 25),

                  const Text(
                    'Peso fresco total por m² (PFT): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _controllerWeightPST,
                      validator: _validateWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Ingresa el peso en gr/m²',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
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
