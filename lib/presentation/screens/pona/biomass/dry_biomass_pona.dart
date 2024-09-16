import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:version/presentation/screens/pona/biomass/biomass_pona.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';

class DryBiomassPona extends StatefulWidget {
  const DryBiomassPona({super.key});

  @override
  State<DryBiomassPona> createState() => _DryBiomassPonaState();
}

class _DryBiomassPonaState extends State<DryBiomassPona> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerDapP = TextEditingController();
  final TextEditingController _controllerDapF = TextEditingController();

  double? resultdbo;

  //Validación del DAP
  String? _validateDap(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa un valor';
    }

    //Validación del AF

    //Validación de regex only numbers
    final dapRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!dapRegExp.hasMatch(value)) {
      return 'Solo se aceptan valores numéricos';
    }
    return null;
  }

  // Cálculo de la biomasa seca

  void _calculateDryBiomassResult() {
    if (_formKey.currentState!.validate()) {
      final double dap = double.parse(_controllerDapP.text);
      final double af = double.parse(_controllerDapF.text);

      final double resultdbo = 0.0080 * dap * af;
      final String formattedResult = resultdbo.toStringAsFixed(2);

      Provider.of<StateBiomassO>(context, listen: false)
          .setDryBiomassO(resultdbo);

      Provider.of<StateBiomassO>(context, listen: false).setDapO(dap);
      Provider.of<StateBiomassO>(context, listen: false).setAfO(af);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Resultado del cáculo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    'La biomasa seca es: $formattedResult T/ha ',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 14),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BiomassPona()));
                      },
                      child: const Text('Aceptar'),
                    )
                  ]));
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
                '¿Qué es la biomasa seca?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'La biomasa seca se refiere a la cantidad de materia orgánica que queda después de eliminar toda el agua contenida en ella. Este proceso se realiza generalmente mediante secado en un horno hasta alcanzar un peso constante. La biomasa seca es una medida importante porque proporciona una estimación precisa de la materia orgánica real, excluyendo el contenido de agua que puede variar significativamente.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
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
                        'assets/img/pona/biomass/biomass_o.png',
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
                    'Calculando la biomasa seca con Pona',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  //Formula
                  SizedBox(height: size.height * 0.03),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 191, 192, 191)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'BS = 0,0080 * (DAP) * (AF)',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  //NOTA
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.12,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*BS: Biomasa seca',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //DAP
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Diámetro a la altura del pecho (DAP): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                    ),
                    child: TextFormField(
                      controller: _controllerDapP,
                      validator: _validateDap,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese el (DAP) en CM',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Altura del fuste
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Altura del fuste (AF): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                    ),
                    child: TextFormField(
                      controller: _controllerDapF,
                      validator: _validateDap,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese la (AF) en CM',
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
                        onPressed: _calculateDryBiomassResult,
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
