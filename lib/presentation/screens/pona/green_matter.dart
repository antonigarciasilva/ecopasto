import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';
import 'package:version/presentation/screens/pona/pona_screen.dart';

class GreenMatterPona extends StatefulWidget {
  const GreenMatterPona({super.key});

  @override
  State<GreenMatterPona> createState() => _GreenMatterPonaState();
}

class _GreenMatterPonaState extends State<GreenMatterPona>
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
    //controllador para la materia verde
    final stateBiomassO = Provider.of<StateBiomassO>(context, listen: false);
    _controllerWeightO = TextEditingController(
      text: stateBiomassO.greenPona?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String? selectedValue;
  //Vamos a validar nuestro formulario
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controllerWeightO = TextEditingController();
  double? greenPona;

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

//Validación del boton

  void _submitForm() {
    final greenMatterO = double.parse(_controllerWeightO.text);
    final greenPona = greenMatterO;

    Provider.of<StateBiomassO>(context, listen: false).setGreenPona(greenPona);
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const PonaScreen()));
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
                '¿Cómo sacar la materia verde?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Se procede al corte y pesado del material vegetativo del SSP, en un área de 1 m², con 3 repeticiones, con el apoyo de un cuadrante de madera o fierro y una hoz se va a realizar el corte a una altura de 05 cm del suelo, para luego pesar las muestras en una balanza de 5kg, expresando el resultado en kg de materia verde/m² (kg mv.m²). \n'
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
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://drive.google.com/uc?id=1xcHKzK6tszGYNGEwMwdCFogACoRh5UGf',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 251, 252, 252)),
                          strokeWidth: 2.5,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: size.height * 0.6,
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
                    'Calculando la materia verde con Pona',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Peso de la materia verde
                  SizedBox(height: size.height * 0.03),

                  //Ingresa el peso de materia verde

                  SizedBox(
                    width: size.width * 0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWeightO,
                      validator: _validateWeightP,
                      decoration: InputDecoration(
                        //prefixIcon: const Icon(Icons.person_4),

                        labelText: 'Peso de materia verde en Kg/m²',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),

                  //Fecha actual
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Fecha de evaluación:   ${getFormattedDate()}',
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                    ],
                  ),

                  //Guardar
                  const SizedBox(height: 15.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 193, 7)),
                        ),
                        onPressed: _submitForm,
                        child: const Text(
                          'Guardar',
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

  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }
}
