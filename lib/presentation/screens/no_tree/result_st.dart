import 'package:flutter/material.dart';

import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';

class ResultSt extends StatelessWidget {
  //Variables de Aliso
  final double resultCarbonBiomass;
  final double totalBiomass;
  final double resultConversionCarbon;
//Variables de ciprés
  final double resultCarbonBiomassC;
  final double totalBiomassC;
  final double resultConversionCarbonC;
//Variables de Pona
  final double resultCarbonBiomassO;
  final double totalBiomassO;
  final double resultConversionCarbonO;
//Variables de Pino
  final double resultCarbonBiomassP;
  final double totalBiomassP;
  final double resultConversionCarbonP;
//Variables de SSA
  final double resultCarbonBiomassST;
  final double resultHerbaceousBiomassST;
  final double resultConversionCarbonST;

  const ResultSt(
      {super.key,
      required this.resultCarbonBiomassC,
      required this.resultCarbonBiomass,
      required this.totalBiomass,
      required this.resultConversionCarbon,
      required this.totalBiomassC,
      required this.resultConversionCarbonC,
      required this.resultCarbonBiomassO,
      required this.totalBiomassO,
      required this.resultConversionCarbonO,
      required this.resultCarbonBiomassP,
      required this.totalBiomassP,
      required this.resultConversionCarbonP,
      required this.resultCarbonBiomassST,
      required this.resultHerbaceousBiomassST,
      required this.resultConversionCarbonST});

  //Vamos a definir los rangos
  String getCarbonLevelC(double resultCarbonBiomassC) {
    if (resultCarbonBiomassC < 50) {
      return 'Bajo';
    } else if (resultCarbonBiomassC < 200) {
      return 'Medio';
    } else {
      return 'Excelente';
    }
  }

  //Vamos a definir las recomendaciones
  String getRecommendationsC(String level) {
    switch (level) {
      case 'Bajo':
        return 'Recomendaciones para mejorar:\n'
            '1. Aumentar la cantidad de árboles \n '
            '2. Implementar técnicas de manejo sostenible';
      case 'Medio':
        return 'Recomendaciones para mejorar: \n'
            '1. Mantener prácticas actuales \n'
            '2. Considerar aumentar áreas de silvopastoreo';
      case 'Excelente':
        return '!Felicitaciones! manten tus practicas actuales y realiza mediciones anuales para asegurar la sostenibilidad';
      default:
        return 'Sin recomendaciones';
    }
  }

  //Recomendación para la próxima medición
  String getNextMeasuremetTimeC(String level) {
    switch (level) {
      case 'Bajo':
        return 'Recomendamos medir de nuevo en 6 meses.';
      case 'Medio':
        return 'Recomendamos medir nuevamente en 1 año';
      case 'Excelente':
        return ' Recomendamos medir nuevamente en 2 años';
      default:
        return 'Sin remendaciones de tiempo';
    }
  }

  //Vamos a insertar imgs
  String getImagePath(String level) {
    switch (level) {
      case 'Bajo':
        return 'assets/result/bajo.jpg';
      case 'Medio':
        return 'assets/result/medio.jpg';
      case 'Excelente':
        return 'assets/result/excelente.jpg';
      default:
        return 'assets/result/medio.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    String level = getCarbonLevelC(resultHerbaceousBiomassST);
    Color levelColor;

    if (level == 'Bajo') {
      levelColor = Colors.red;
    } else if (level == 'Medio') {
      levelColor = Colors.yellow;
    } else {
      levelColor = Colors.green;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Resultado de cálculo'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),

                  SizedBox(
                      child: Image.asset(
                    getImagePath(level),
                    height: 200,
                  )),
                  const SizedBox(
                    height: 20,
                  ),

                  Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(75),
                      1: FixedColumnWidth(42),
                      2: FixedColumnWidth(42),
                      3: FixedColumnWidth(42),
                      4: FixedColumnWidth(42),
                      5: FixedColumnWidth(42),
                    },
                    children: [
                      //Títulos de la cabecera
                      TableRow(children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            'Variables',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            'Aliso',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            'Ciprés',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            'Pino',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            'Pona',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            'SSA',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                      //Primera fila de datos

                      TableRow(children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            'Retención de  carbono total',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        //Aliso
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultCarbonBiomass.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Ciprés
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultCarbonBiomassC.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Pino
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultCarbonBiomassP.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Pona
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultCarbonBiomassO.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //SSA
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultCarbonBiomassST.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                      //Segunda fila de datos

                      TableRow(children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            'Biomasa vegetal total',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        //Aliso
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${totalBiomass.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Ciprés
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${totalBiomassC.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Pino
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${totalBiomassP.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Pona
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${totalBiomassO.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //SSA
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultHerbaceousBiomassST.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),

                      //Tercera fila de datos

                      TableRow(children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            'Dióxido de carbomo',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        //Aliso
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultConversionCarbon.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Ciprés
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultConversionCarbonC.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Pino
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultConversionCarbonP.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Pona
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultConversionCarbonO.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //SSA
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${resultConversionCarbonST.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ])
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'El carbono total en la biomasa es de: ${resultCarbonBiomassST.toStringAsFixed(2)} T/ha',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nivel de carbono: $level',
                    style: TextStyle(fontSize: 21, color: levelColor),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    getRecommendationsC(level),
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    getNextMeasuremetTimeC(level),
                    style: const TextStyle(
                        fontSize: 15, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Botón de regreso
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.green)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CarbonScreenC()));
                      },
                      child: const Text('Aceptar',
                          style: TextStyle(fontSize: 18, color: Colors.white)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
