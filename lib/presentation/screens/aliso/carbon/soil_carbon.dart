import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/carbon/carbon.dart';

class SoilCarbonScreen extends StatefulWidget {
  const SoilCarbonScreen({super.key});

  @override
  State<SoilCarbonScreen> createState() => _SoilCarbonScreenState();
}

class _SoilCarbonScreenState extends State<SoilCarbonScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightA = TextEditingController();
  final TextEditingController _controllerWeightP = TextEditingController();

  String? _selectedSoilType;
  double? _soilDensity;

  //Validación de los pesos
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa un valor';
    }
    //Validación con regex
    final soilRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!soilRegExp.hasMatch(value)) {
      return 'Solo acepta valores numéricos';
    }
    return null;
  }

  // Calcular el carbono en el suelo
  void _calculateAndShowResult() {
    if (_formKey.currentState!.validate()) {
      if (_soilDensity == null) {
        _showValidationDialog(
            'Por favor, ingresa la densidad aparente del suelo para continuar.');
        return;
      }
      final double area = double.parse(_controllerWeightA.text);
      final double depth = double.parse(_controllerWeightP.text);

      final double result = area * depth * _soilDensity!;

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
            'El peso del suelo (Ws) es: ${result.toStringAsFixed(2)} T/ha',
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CarbonScreen()),
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
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  //Mostrar el dialogo de advertencia de llenar tipo de suelo
  void _showValidationDialog(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
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
                        'assets/img/aliso/carbon/soil_carbon_a.jpg',
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
                      fontSize: 20,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.18,
                    ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                    ),
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: _controllerWeightA,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                    ),
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: _controllerWeightP,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedSoilType,
                      items: const [
                        DropdownMenuItem(
                            value: 'arcilloso-franco',
                            child: Text(
                              'Arcilloso-franco (1.1 g/cm³)',
                              style: TextStyle(fontSize: 14),
                            )),
                        DropdownMenuItem(
                            value: 'franco-arenoso',
                            child: Text(
                              'Franco-arenoso (1.32 g/cm³)',
                              style: TextStyle(fontSize: 14),
                            )),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedSoilType = value;
                          _soilDensity =
                              value == 'arcilloso-franco' ? 1.1 : 1.32;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Seleccione el tipo de suelo',
                        labelStyle: const TextStyle(fontSize: 14),
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

/* 
Calculo interno 
CO (Tm/ha) = Ws * %CO
CO = Carbono orgánico (Tm/ha)
Ws= peso del suelo calculado (Tm/ha)
CO = Carbono calculado en laboratorio (%)

Para optener el carbono en el suelo
*/
