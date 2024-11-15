import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';

import 'package:version/presentation/screens/pona/pona_screen.dart';

class DryPonaScreen extends StatefulWidget {
  const DryPonaScreen({super.key});

  @override
  State<DryPonaScreen> createState() => _DryPonaScreenState();
}

class _DryPonaScreenState extends State<DryPonaScreen>
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
    //Inicializamos el controller
    final stateBiomassO = Provider.of<StateBiomassO>(context, listen: false);
    _controllerWeightDry = TextEditingController(
      text: stateBiomassO.pmsO?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //Vamos a validar nuestro formulario
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controllerWeightDry = TextEditingController();
  //Creamos la variable para el provider
  StateBiomassO? stateBiomassO;
  //Invocamos el provider
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassO = Provider.of<StateBiomassO>(context);
  }

  double? dryMatterPona;

  //Validar form de peso
  String? _validateWeightP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }

    final weightRegExp = RegExp(r'^\d{1,5}(\.\d{1,2})?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Valores numéricos hasta 7 cifras, dos decimales.';
    }
    return null;
  }

// Cálculo de la materia seca

  void _calculateDryMatterResult() {
    if (_formKey.currentState!.validate()) {
      final double pms = double.parse(_controllerWeightDry.text);

      final double dryMatterPona = pms / (stateBiomassO!.greenPona ?? 0) * 100;
      final String formattedResult = dryMatterPona.toStringAsFixed(2);

      Provider.of<StateBiomassO>(context, listen: false)
          .setDryMatterPona(dryMatterPona);

      Provider.of<StateBiomassO>(context, listen: false).setPmsO(pms);

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
                    'El peso de la materia seca es: $formattedResult % MS ',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 14),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PonaScreen()));
                      },
                      child: const Text('Aceptar'),
                    )
                  ]));
    }
  }

  //Funcion de boton informativo
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Cómo sacar el peso de la muestra seca (PMS)?',
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
                        'assets/img/pona/drymatter/dry_o.jpg',
                        fit: BoxFit.cover,
                        height: size.height * 0.55,
                      ),
                    ),

                    //Position of the buttom
                    Positioned(
                      top: size.height * 0.05,
                      right: size.width * 0.01,
                      child: FilledButton.tonal(
                        onPressed: () => openDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),

                  //Título
                  SizedBox(height: size.height * 0.03),
                  const Text(
                    'Calculando la materia seca con Pona',
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
                        horizontal: size.width * 0.12,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*MS: materia seca \n'
                          '*PMS: Peso de la materia seca \n'
                          '*PMH: Peso de la materia húmeda \n'
                          '*m²: metro cuadrado ',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //Peso de la materia seca
                  SizedBox(height: size.height * 0.03),

                  SizedBox(
                    width: size.width * 0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWeightDry,
                      validator: _validateWeightP,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Ingresa el PMS en Kg',
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
                              const Color.fromARGB(255, 255, 193, 7)),
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
