import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/biomass.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';

class NewDryBiomassScreen extends StatefulWidget {
  const NewDryBiomassScreen({super.key});

  @override
  State<NewDryBiomassScreen> createState() => _NewDryBiomassScreenState();
}

class _NewDryBiomassScreenState extends State<NewDryBiomassScreen>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerDap = TextEditingController();
  double? dryBiomass;

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

  //Validación del DAP
  String? _validateDap(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa el DAP';
    }
    // Validación de regex solo números
    final dapRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!dapRegExp.hasMatch(value)) {
      return 'Solo se aceptan valores numéricos';
    }
    return null;
  }

  //Función para calcular la biomasa seca
  void _calculateDryBiomass() {
    if (_formKey.currentState!.validate()) {
      double dap = double.parse(_controllerDap.text);

      dryBiomass = -22.695 + 1.5085 * (dap);
      final String formattedResult = dryBiomass!.toStringAsFixed(2);

      Provider.of<StateBiomass>(context, listen: false)
          .setDryBiomass(dryBiomass!);
      Provider.of<StateBiomass>(context, listen: false).setDap(dap);

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
                    'La biomasa seca es: $formattedResult T/ha',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BiomassAlderScreen(),
                          ),
                        );
                      },
                      child: const Text('Aceptar'),
                    )
                  ]));
    }
  }

  //Dialogo de información sobre la biomasa seca
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuando le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es la biomasa seca?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'La biomasa seca es la materia orgánica total de un árbol, medida en peso seco. Se calcula usando el diámetro a la altura del pecho (DAP) y fórmulas alométricas específicas para cada especie.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
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
      body: SafeArea(
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
                      'assets/img/aliso/biomass/al_dry_biomass.jpg',
                      fit: BoxFit.fitWidth,
                      height: size.height * 0.55,
                      color: Colors.black.withOpacity(0.3),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  //Posición del botón
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
                  'Calculando la biomasa seca',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
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
                        'C = -22.695 + 1.5085 * DAP',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),

                //Formulario del DAP
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerDap,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Ingrese el DAP (cm)',
                            labelStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          validator: _validateDap,
                        ),

                        //Calcular
                        SizedBox(height: size.height * 0.03),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 51, 79, 31)),
                          ),
                          onPressed: _calculateDryBiomass,
                          child: const Text(
                            'Calcular',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        if (dryBiomass != null)
                          Visibility(
                            visible: false,
                            child: Text(
                              ' ${dryBiomass?.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
