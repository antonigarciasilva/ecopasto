import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';
import 'package:version/presentation/screens/pino/carbon/carbon.dart';

class SoilCarbonPino extends StatefulWidget {
  const SoilCarbonPino({super.key});

  @override
  State<SoilCarbonPino> createState() => _SoilCarbonPinoState();
}

class _SoilCarbonPinoState extends State<SoilCarbonPino>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ignore: avoid_print
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    final stateBiomassP = Provider.of<StateBiomassP>(context, listen: false);
    controllerWeightAreaP = TextEditingController(
      text: stateBiomassP.areaP?.toString() ?? '',
    );
    controllerWeightDepthP = TextEditingController(
      text: stateBiomassP.depthP?.toString() ?? '',
    );

    soilDensityP = stateBiomassP.soilDensityP;
    selectedSoilTypeP = stateBiomassP.selectedSoilTypeP;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  late TextEditingController controllerWeightAreaP = TextEditingController();
  late TextEditingController controllerWeightDepthP = TextEditingController();

  String? selectedSoilTypeP;
  double? soilDensityP;

  //Validación de los pesos
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa un valor2';
    }
    //Validación con regex
    final weightRegExp = RegExp(r'^\d{1,5}(\.\d{1,2})?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Valores numéricos hasta 7 cifras, dos decimales.';
    }
    return null;
  }

  // Calcular el carbono en el suelo
  void _calculateAndShowResult() {
    if (_formKey.currentState!.validate()) {
      if (soilDensityP == null) {
        _showValidationDialog(
            'Por favor, ingresa la densidad aparente del suelo para continuar.');
        return;
      }
      final double areaP = double.parse(controllerWeightAreaP.text);
      final double depthP = double.parse(controllerWeightDepthP.text);

      Provider.of<StateBiomassP>(context, listen: false).setAreaP(areaP);

      Provider.of<StateBiomassP>(context, listen: false).setDepthP(depthP);

      final double resultSoilP = areaP * depthP * soilDensityP!;
      Provider.of<StateBiomassP>(context, listen: false)
          .setTotalSoilCarbonP(resultSoilP);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Resultado del cálculo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'El peso del suelo (Ws) es: ${resultSoilP.toStringAsFixed(2)} T/ha',
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
                      builder: (context) => const CarbonPinoScreen()),
                );
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

//Dialogo informativo sobre el carbono
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es el carbono en el suelo?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Es el carbono orgánico almacenado, proveniente de la descomposición de plantas y microorganismos. Es clave para mejorar la calidad del suelo y mitigar el cambio climático al reducir el CO₂ en la atmósfera \n'
                '(Vásquez, 2023)',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SoilCarbonPino()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  void _showValidationDialog(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text('Validación'),
              content: Text(message),
              actions: [
                TextButton(
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
                        'assets/img/pino/carbon/suelo_p.jpg',
                        fit: BoxFit.fitWidth,
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
                    'Calculando carbono en el suelo',
                    style: TextStyle(
                      fontSize: 18,
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
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Ws (T/ha) = a * p * da',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //NOTA
                  SizedBox(height: size.height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*Ws: Peso del suelo (T/ha) ',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),

                  //Área
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Área (a): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: controllerWeightAreaP,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese el (a) en hectáreas',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Profundidad
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Profundidad (p): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: controllerWeightDepthP,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingresa la (p) en metros',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Densidad aparente del suelo
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Densidad aparente del suelo (da): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: DropdownButtonFormField(
                      value: selectedSoilTypeP,
                      items: const [
                        DropdownMenuItem(
                            value: 'arcilloso-franco',
                            child: Text(
                              'Arcillo-Franco (1.1 g/cm³)',
                              style: TextStyle(fontSize: 14),
                            )),
                        DropdownMenuItem(
                            value: 'franco-arenoso',
                            child: Text('Franco - Arenoso (1.32 g/cm³)',
                                style: TextStyle(fontSize: 14))),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          selectedSoilTypeP = value;
                          soilDensityP =
                              value == 'arcilloso-franco' ? 1.1 : 1.32;
                          Provider.of<StateBiomassP>(context, listen: false)
                              .setSelectedSoilTypeP(soilDensityP!, value!);
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese la (da) en g/cm³',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      dropdownColor: Colors.white,
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
                        onPressed: _calculateAndShowResult,
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
