import 'package:flutter/material.dart';
import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';

class HerbaceousBiomassC extends StatefulWidget {
  const HerbaceousBiomassC({super.key});

  @override
  State<HerbaceousBiomassC> createState() => _HerbaceousBiomassCState();
}

class _HerbaceousBiomassCState extends State<HerbaceousBiomassC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightPSM = TextEditingController();
  final TextEditingController _controllerWeightPFM = TextEditingController();
  final TextEditingController _controllerWeightPST = TextEditingController();

  //Validación del peso
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }
    //Validación de peso
    final weightRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Solo acepta valores númericos';
    }
    return null;
  }

  //Validación el bottom guardar
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
                '¿Qué es la biomasa herbácea?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'La biomasa herbácea se refiere a la materia orgánica de las plantas herbáceas, que son plantas no leñosas como pastos, flores silvestres y otras plantas de bajo crecimiento. Estas plantas suelen ser de ciclo de vida corto y juegan un papel importante en los ecosistemas, proporcionando alimento para herbívoros, contribuyendo a la estabilidad del suelo y participando en los ciclos de nutrientes.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HerbaceousBiomassC()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Calculando la biomasa herbácea con Ciprés',
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
                      width: 320,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'BH(Tm/ha) = ((PSM/PFM) * PFT) * 0.01',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //NOTA
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*BH: Biomasa herbácea(Tm/ha) \n'
                          '*0.01: Factor de conversión para biomasa herbácea \n',
                          style: TextStyle(fontSize: 10),
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

                  //PSM
                  const SizedBox(height: 25),

                  const Text(
                    'Peso seco de la materia (PSM): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

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
                  const SizedBox(height: 25),

                  const Text(
                    'Peso fresco de la muestra (PFM): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
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

                  //PST
                  const SizedBox(height: 25),

                  const Text(
                    'Peso fresco total por m² (PFT): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _controllerWeightPST,
                      validator: _validateWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Ingresa el peso en gr/m²',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
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
      ),
    );
  }
}
