import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';

import 'package:version/presentation/screens/cipres/cipres_screen.dart';

class DryMatterC extends StatefulWidget {
  const DryMatterC({super.key});

  @override
  State<DryMatterC> createState() => _DryMatterCState();
}

class _DryMatterCState extends State<DryMatterC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightDry = TextEditingController();
  //Creamos el provider
  StateBiomassC? stateBiomassC;
  //Para usar el provider
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassC = Provider.of<StateBiomassC>(context);
  }

  double? dryMatterCipres;

  //Validar el peso
  String? _validateWeightC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }
    final weightRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Solo se acepta valores numéricos';
    }
    return null;
  }

  // Cálculo de la materia seca

  void _calculateDryMatterResult() {
    if (_formKey.currentState!.validate()) {
      final double pms = double.parse(_controllerWeightDry.text);

      final double dryMatterCipres =
          pms / (stateBiomassC!.greenCipres ?? 0) * 100;
      final String formattedResult = dryMatterCipres.toStringAsFixed(2);

      Provider.of<StateBiomassC>(context, listen: false)
          .setDryMatterCipres(dryMatterCipres);

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
                    'El peso de la materia seca es: $formattedResult % MS',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CipresScreen()));
                      },
                      child: const Text('Aceptar'),
                    )
                  ]));
    }
  }

//Función de botón informativo

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //Solo para salir con los botones y no cuando le das click a cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Cómo sacar el peso de la muestra seca (PSM)',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Se emplea una sub muestra de la materia verde de 500g dependiendo de la cantidad de pastura, luego, se coloca en una estufa a 60 °C, hasta obtener un peso constante y con la ayuda de una balanza de 1 Kg se obtiene el PSM\n'
                '(Vásquez, 2023)',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
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
    //responsive
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/img/cipres/drymatter/dry_c.jpg',
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
                    'Calculando la materia seca con pino',
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
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 191, 192, 191)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'MS/m² (Kg) = PMS/PMH * 100',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  //NOTA
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.15,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*MS: materia seca \n'
                          '*m²: metro cuadrado',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //Peso de la materia seca
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Peso de la materia seca (PMS): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWeightDry,
                      validator: _validateWeightC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingresa el peso en Kg',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Guardar
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
                        onPressed: _calculateDryMatterResult,
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
