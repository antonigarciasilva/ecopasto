import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:version/presentation/screens/select_system/new_select_silvo_screen.dart';

//Clase para representar los datos para el gráfico
class BiomassData {
  final String treeType;
  final String variable;
  final double value;

  BiomassData(
    this.treeType,
    this.variable,
    this.value,
  );
}

class ResultCarbonBiomass extends StatelessWidget {
  //Preparamos las listas para el gráfico
  List<BiomassData> getchartDate() {
    return [
      //Aliso
      BiomassData(
        'Aliso',
        'TB',
        totalBiomass,
      ),
      BiomassData('Aliso', 'CB', resultCarbonBiomass),
      BiomassData('Aliso', 'CC', resultConversionCarbon),

      //Ciprés
      BiomassData(
        'Cipres',
        'TB',
        totalBiomassC,
      ),
      BiomassData('Cipres', 'CB', resultCarbonBiomassC),
      BiomassData('Cipres', 'CC', resultConversionCarbonC),

      //Pino
      BiomassData(
        'Pino',
        'TB',
        totalBiomassP,
      ),
      BiomassData('Pino', 'CB', resultCarbonBiomassP),
      BiomassData('Pino', 'CC', resultConversionCarbonP),
      //Pona
      BiomassData(
        'Pona',
        'TB',
        totalBiomassO,
      ),
      BiomassData('Pona', 'CB', resultCarbonBiomassO),
      BiomassData('Pona', 'CC', resultConversionCarbonO),

      //SSA
      BiomassData(
        'Ssa',
        'TB',
        resultHerbaceousBiomassST,
      ),
      BiomassData('Pona', 'CB', resultCarbonBiomassST),
      BiomassData('Pona', 'CC', resultConversionCarbonST),
    ];
  }

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

  const ResultCarbonBiomass({
    super.key,
    required this.resultCarbonBiomass,
    required this.totalBiomass,
    required this.resultConversionCarbon,
    required this.resultCarbonBiomassC,
    required this.totalBiomassC,
    required this.resultConversionCarbonC,
    required this.resultCarbonBiomassO,
    required this.totalBiomassO,
    required this.resultConversionCarbonO,
    required this.resultCarbonBiomassST,
    required this.resultHerbaceousBiomassST,
    required this.resultConversionCarbonST,
    required this.resultCarbonBiomassP,
    required this.totalBiomassP,
    required this.resultConversionCarbonP,
  });

  //Vamos a definir los rangos
  String getCarbonLevel(double resultCarbonBiomass) {
    if (resultCarbonBiomass < 50) {
      return 'Bajo';
    } else if (resultCarbonBiomass < 200) {
      return 'Medio';
    } else {
      return 'Excelente';
    }
  }

  //Vamos a definir las recomendaciones
  String getRecommendations(String level) {
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
  String getNextMeasuremetTime(String level) {
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
    String level = getCarbonLevel(resultCarbonBiomass);
    Color levelColor;
    final List<BiomassData> chartData = getchartDate();

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
          title: const Text('Resultado del cálculo'),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
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
                            0: FixedColumnWidth(73),
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

                        //Implementamos el gráfico
                        SizedBox(
                          height: 350,
                          width: 290,
                          //Inicializamos el gráfico cartesiano
                          child: SfCartesianChart(
                            title: const ChartTitle(
                                text: 'Análisis de biomasa y carbono \n'
                                    'en Sistemas Silvopastoriles',
                                textStyle: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            //Personalizando el eje x
                            primaryXAxis: const CategoryAxis(
                              title: AxisTitle(
                                  text: 'Variables',
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              labelStyle: TextStyle(
                                fontSize: 12,
                              ),
                            ),

                            //Personalizando el eje y
                            primaryYAxis: const NumericAxis(
                              title: AxisTitle(
                                  text: 'T / ha',
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              interval: 50,
                              minimum: 0,
                              maximum: 1000,
                              majorGridLines: MajorGridLines(width: 1),
                            ),

                            legend: const Legend(isVisible: true),

                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries>[
                              LineSeries<BiomassData, String>(
                                dataSource: chartData
                                    .where((data) => data.treeType == 'Aliso')
                                    .toList(),
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
                                name: 'Aliso',
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                              LineSeries<BiomassData, String>(
                                dataSource: chartData
                                    .where((data) => data.treeType == 'Cipres')
                                    .toList(),
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
                                name: 'Ciprés',
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                              LineSeries<BiomassData, String>(
                                dataSource: chartData
                                    .where((data) => data.treeType == 'Pino')
                                    .toList(),
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
                                name: 'Pino',
                                color: Colors.red,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                              LineSeries<BiomassData, String>(
                                dataSource: chartData
                                    .where((data) => data.treeType == 'Pona')
                                    .toList(),
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
                                name: 'Pona',
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                              LineSeries<BiomassData, String>(
                                dataSource: chartData
                                    .where((data) => data.treeType == 'SSA')
                                    .toList(),
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
                                name: 'SSA',
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'El carbono total en la biomasa es de: ${resultCarbonBiomass.toStringAsFixed(2)} T/ha',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
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
                          getRecommendations(level),
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          getNextMeasuremetTime(level),
                          style: const TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //Boton de aceptar
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.green)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NewSelectSilvoScreen()));
                            },
                            child: const Text('Aceptar',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)))
                      ])),
            ),
          ),
        ));
  }
}
