import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';

class DryBiomassCNew extends StatefulWidget {
  const DryBiomassCNew({super.key});

  @override
  State<DryBiomassCNew> createState() => _DryBiomassCNewState();
}

class _DryBiomassCNewState extends State<DryBiomassCNew> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerDapP = TextEditingController();
  double? resultdbc;

  // Validación del DAP
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

  // Cálculo de la biomasa seca
  void _calculateDryBiomassResult() {
    if (_formKey.currentState!.validate()) {
      final double dap = double.parse(_controllerDapP.text);

      resultdbc = 0.2639 * dap;
      final String formattedResult = resultdbc!.toStringAsFixed(2);

      Provider.of<StateBiomassC>(context, listen: false)
          .setDryBiomassC(resultdbc!);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                  title: const Text(
                    'Resultado del cáculo',
                    style: TextStyle(fontSize: 18),
                  ),
                  content: Text(
                    'La biomasa seca es: $formattedResult ',
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
                      child: const Text('Aceptar'),
                    )
                  ]));
    }
  }

  // Diálogo informativo sobre el Aliso
  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      // solo para salir con los botones y no cuando le das click en cualquier lado
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          '¿Qué es la biomasa seca?',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18),
        ),
        content: const Text(
          'La biomasa seca se refiere a la cantidad de materia orgánica que queda después de eliminar toda el agua contenida en ella. Este proceso se realiza generalmente mediante secado en un horno hasta alcanzar un peso constante. La biomasa seca es una medida importante porque proporciona una estimación precisa de la materia orgánica real, excluyendo el contenido de agua que puede variar significativamente.',
          textAlign: TextAlign.justify,
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            //es para el rebote al final de la pantalla
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/img/cipres/biomass/biomass_c.jpg',
                        fit: BoxFit.fitWidth,
                        height: 259,
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 50,
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
                  ],
                ),

                //Título
                const SizedBox(height: 25.0),
                const Text(
                  'Calculando la biomasa seca',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                //Formula
                const SizedBox(height: 25.0),
                MouseRegion(
                  //Para convertir en una manito cuando pase por ahí el mouse
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 191, 192, 191),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'C = 0,2639 * (DAP)',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),

                //Formulario DAP
                const SizedBox(height: 25),
                const Text(
                  'Diámetro a la altura del pecho (DAP): ',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 8,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _controllerDapP,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Ingrese el (DAP) en cm',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      validator: _validateDap,
                      textAlign: TextAlign.center,
                    ),
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
                          const Color.fromARGB(255, 70, 150, 13),
                        ),
                      ),
                      onPressed: _calculateDryBiomassResult,
                      child: const Text(
                        'Calcular',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (resultdbc != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Visibility(
                      visible: false,
                      child: Text(
                        'Biomasa seca calculada: ${resultdbc!.toStringAsFixed(2)}',
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
