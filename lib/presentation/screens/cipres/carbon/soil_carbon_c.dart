import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';

class SoilCarbonC extends StatefulWidget {
  const SoilCarbonC({super.key});

  @override
  State<SoilCarbonC> createState() => _SoilCarbonCState();
}

class _SoilCarbonCState extends State<SoilCarbonC> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController controllerWeightAreaC = TextEditingController();
  late TextEditingController controllerWeightDepthC = TextEditingController();

  String? selectedSoilTypeC;
  double? soilDensityC;

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

    final stateBiomassC = Provider.of<StateBiomassC>(context, listen: false);
    controllerWeightAreaC = TextEditingController(
      text: stateBiomassC.areaC?.toString() ?? '',
    );
    controllerWeightDepthC = TextEditingController(
      text: stateBiomassC.depthC?.toString() ?? '',
    );

    soilDensityC = stateBiomassC.soilDensity;
    selectedSoilTypeC = stateBiomassC.selectedSoilTypeC;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //Validación de los pesos
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un valor';
    }
    //Validación con regex
    final weightRegExp = RegExp(r'^\d{1,5}(\.\d{1,2})?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Valores numéricos hasta 7 cifras, dos decimales.';
    }
    return null;
  }

  //Función para escoger el tipo de terreno
  void _onSoilTypeChanged(String? value) {
    setState(() {
      selectedSoilTypeC = value;
      soilDensityC = value == 'arcilloso-franco' ? 1.1 : 1.32;
      Provider.of<StateBiomassC>(context, listen: false)
          .setSelectedSoilTypeC(soilDensityC!, value!);
    });
  }

  //Calculamos el carbono en el suelo

  void _calculateAndShowResult() {
    if (_formKey.currentState!.validate()) {
      final double areaC = double.parse(controllerWeightAreaC.text);
      final double depthC = double.parse(controllerWeightDepthC.text);

      Provider.of<StateBiomassC>(context, listen: false).setAreaC(areaC);

      Provider.of<StateBiomassC>(context, listen: false).setDepthC(depthC);

      final double resultSoilC = areaC * depthC * soilDensityC!;
      Provider.of<StateBiomassC>(context, listen: false)
          .setTotalSoilCarbonC(resultSoilC);

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
                    'El peso del suelo (Ws) es: ${resultSoilC.toStringAsFixed(2)} T/ha',
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
                                  builder: (context) => const CarbonScreenC()));
                        },
                        child: const Text('Aceptar'))
                  ]));
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
                      child: SizedBox(
                        height: size.height * 0.6,
                        child: Image.asset(
                            'assets/img/cipres/greenmatter/green_mater.jpeg',
                            fit: BoxFit.cover),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Formula
                  SizedBox(height: size.height * 0.03),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*Ws: Peso del suelo (T/ha) \n '
                        '*a = Área\n'
                        '*p = Profundidad \n'
                        '*da = Densidad aparente ',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),

                  //Área
                  SizedBox(height: size.height * 0.03),

                  SizedBox(
                    width: size.width * 0.8,
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: controllerWeightAreaC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese el a en hectáreas',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Profundidad
                  SizedBox(height: size.height * 0.03),

                  SizedBox(
                    width: size.width * 0.8,
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: controllerWeightDepthC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingresa la p en metros',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Densidad aparente del suelo
                  SizedBox(height: size.height * 0.03),

                  SizedBox(
                    width: size.width * 0.8,
                    child: DropdownButtonFormField(
                      value: selectedSoilTypeC,
                      items: const [
                        DropdownMenuItem(
                            value: 'arcilloso-franco',
                            child: Text(
                              'Arcilloso-Franco 1.1 g/cm³',
                              style: TextStyle(fontSize: 14),
                            )),
                        DropdownMenuItem(
                            value: 'franco-arenoso',
                            child: Text(
                              'Franco-Arenoso 1.32 g/cm³',
                              style: TextStyle(fontSize: 14),
                            )),
                      ],
                      onChanged: _onSoilTypeChanged,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese la (da) en g/cm³',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      dropdownColor: Colors.white,
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
                              const Color.fromARGB(255, 255, 193, 7)),
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
