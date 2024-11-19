import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';

class DryBiomassCNew extends StatefulWidget {
  const DryBiomassCNew({super.key});

  @override
  State<DryBiomassCNew> createState() => _DryBiomassCNewState();
}

class _DryBiomassCNewState extends State<DryBiomassCNew>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controllerDapP = TextEditingController();
  double? dryBiomassC;

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
    final stateBiomassC = Provider.of<StateBiomassC>(context, listen: false);
    _controllerDapP = TextEditingController(
      text: stateBiomassC.dapC?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Validación del DAP
  String? _validateDap(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa el DAP';
    }
    // Validación de regex solo números
    final weightRegExp = RegExp(r'^\d{1,5}(\.\d{1,2})?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Valores numéricos hasta 7 cifras, dos decimales.';
    }
    return null;
  }

  // Cálculo de la biomasa seca
  void _calculateDryBiomassResult() {
    if (_formKey.currentState!.validate()) {
      final double dap = double.parse(_controllerDapP.text);

      dryBiomassC = 0.2639 * dap;
      final String formattedResult = dryBiomassC!.toStringAsFixed(2);

      Provider.of<StateBiomassC>(context, listen: false)
          .setDryBiomassC(dryBiomassC!);
      Provider.of<StateBiomassC>(context, listen: false).setDapC(dap);

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
                    'La biomasa seca es: $formattedResult ',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
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
        backgroundColor: Colors.white,
        title: const Text(
          '¿Qué es la biomasa seca?',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Se refiere a la cantidad de materia orgánica sin contenido de agua en los componentes de un sistema silvopastoril, como árboles, pastos y hojarasca. La biomasa seca es crucial para calcular el carbono almacenado, lo cual es un indicador del potencial de mitigación de emisiones en estos sistemas \n'
          '(Vásquez, 2023)',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 14),
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
    //responsive
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://drive.google.com/uc?id=122R7RA2D_PPXkP2a_oyMU2XG--YD3Qzy',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 251, 252, 252)),
                          strokeWidth: 2.5,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fitWidth,
                        height: size.height * 0.55,
                      ),
                    ),
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
                  ],
                ),

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

                //NOTA
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.18,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*DAP: Diámetro a la altura del pecho \n',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),

                //Formulario DAP
                SizedBox(height: size.height * 0.03),

                Form(
                  key: _formKey,
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: TextFormField(
                      controller: _controllerDapP,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Ingrese el DAP en cm',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      validator: _validateDap,
                      textAlign: TextAlign.center,
                    ),
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
                          const Color.fromARGB(255, 255, 193, 7),
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
                if (dryBiomassC != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 00.0),
                    child: Visibility(
                      visible: false,
                      child: Text(
                        'Biomasa seca calculada: ${dryBiomassC!.toStringAsFixed(2)}',
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
