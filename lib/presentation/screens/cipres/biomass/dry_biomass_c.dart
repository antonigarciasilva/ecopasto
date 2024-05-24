import 'package:flutter/material.dart';
import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';

class DryBiomassC extends StatefulWidget {
  const DryBiomassC({super.key});

  @override
  State<DryBiomassC> createState() => _DryBiomassCState();
}

class _DryBiomassCState extends State<DryBiomassC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerDapP = TextEditingController();

  //Validación del DAP
  String? _validateDap(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa el DAP';
    }
    //Validación de regex only numbers
    final dapRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!dapRegExp.hasMatch(value)) {
      return 'Solo se aceptan valores numéricos';
    }
    return null;
  }

  //Validamos el bottomn guardar

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BiomassScreenC()));
    }
  }

  //Dialogo informativo sobre el Aliso
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es la biomasa seca?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'La biomasa seca se refiere a la cantidad de materia orgánica que queda después de eliminar toda el agua contenida en ella. Este proceso se realiza generalmente mediante secado en un horno hasta alcanzar un peso constante. La biomasa seca es una medida importante porque proporciona una estimación precisa de la materia orgánica real, excluyendo el contenido de agua que puede variar significativamente.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DryBiomassC()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'assets/img/cipres/biomass/biomass_c.jpg',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),

                  //Possition of the botton
                  Positioned(
                    right: 5,
                    top: 50,
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
                const SizedBox(height: 25.0),
                const Text(
                  'Calculando la biomasa seca con Pino',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //Formula
                const SizedBox(height: 25.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 191, 192, 191)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'C = 0,2639 * (DAP)',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),

                //Día de evaluación
                const SizedBox(height: 20.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Día de evaluación: ',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                    SizedBox(width: 20),
                  ],
                ),

                //DAP
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
                ),

                //Guardar
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
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
    );
  }
}
