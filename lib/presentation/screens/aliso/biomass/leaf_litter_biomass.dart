import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/biomass/biomass.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';

class LeafLitterBiomassScreen extends StatefulWidget {
  const LeafLitterBiomassScreen({super.key});

  @override
  State<LeafLitterBiomassScreen> createState() =>
      _LeafLitterBiomassScreenState();
}

class _LeafLitterBiomassScreenState extends State<LeafLitterBiomassScreen>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightPSM = TextEditingController();
  final TextEditingController _controllerWeightPFM = TextEditingController();

  double? resultbha;

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
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //Validación de peso
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }
    //Validación con regex
    final weightRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Solo acepta valores numéricos';
    }
    return null;
  }

  // Calculo de la biomasa hojarasca

  void _calculateLeafLitterBiomassResult() {
    if (_formKey.currentState!.validate()) {
      final double psm = double.parse(_controllerWeightPSM.text);
      final double pfm = double.parse(_controllerWeightPFM.text);

      final double leafLitterBiomass = ((psm / pfm) * pfm) * 0.04;
      final String formattedResult = leafLitterBiomass.toStringAsFixed(2);

      Provider.of<StateBiomass>(context, listen: false)
          .setLeafLitterBiomass(leafLitterBiomass);

      Provider.of<StateBiomass>(context, listen: false).setPsm(psm);

      Provider.of<StateBiomass>(context, listen: false).setPfm(pfm);

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
                  'La biomasa herbácea es: $formattedResult T/ha',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BiomassAlderScreen()));
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
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es la biomasa hojarasca?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'La biomasa de hojarasca incluye las hojas caídas, ramas pequeñas, flores, frutos y otros restos vegetales que se acumulan en el suelo del bosque o de cualquier área con vegetación arbórea. Esta hojarasca es una fuente crucial de nutrientes para el suelo, ya que se descompone y enriquece el suelo con materia orgánica, mejorando su estructura y fertilidad.',
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
                        'assets/img/aliso/biomass/al_biomass_leaf.jpg',
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
                    'Calculando la biomasa hojarasca con Aliso',
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
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*BH: Biomasa hojarasca(T/ha) \n'
                          '*PFT: Peso fresco total por m² \n'
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
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    'Peso fresco de la muestra (PFM): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: size.height * 0.01),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                    ),
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
                        onPressed: _calculateLeafLitterBiomassResult,
                        child: const Text(
                          'Calcular',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      //Validación de botton
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
