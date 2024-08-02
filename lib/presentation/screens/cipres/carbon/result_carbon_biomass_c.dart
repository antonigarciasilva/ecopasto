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

class ResultCarbonBiomassC extends StatelessWidget {
  //Preparamos las listas para el gráfico
  List<BiomassData> getchartDate() {
    return [
      //Aliso
      BiomassData(
        'Aliso',
        'Biomasa vegetal',
        totalBiomass,
      ),
      BiomassData('Aliso', 'Retención de carbono', resultCarbonBiomass),
      BiomassData('Aliso', 'Dióxido de carbono', resultConversionCarbon),
      BiomassData('Aliso', 'Total', sumaTotal),

      //Ciprés
      BiomassData(
        'Cipres',
        'Biomasa vegetal',
        totalBiomassC,
      ),
      BiomassData('Cipres', 'Retención de carbono', resultCarbonBiomassC),
      BiomassData('Cipres', 'Dióxido de carbono', resultConversionCarbonC),
      BiomassData('Cipres', 'Total', sumaTotalC),

      //Pino
      BiomassData(
        'Pino',
        'Biomasa vegetal',
        totalBiomassP,
      ),
      BiomassData('Pino', 'Retención de carbono', resultCarbonBiomassP),
      BiomassData('Pino', 'Dióxido de carbono', resultConversionCarbonP),
      BiomassData('Pino', 'Total', sumaTotalP),
      //Pona
      BiomassData(
        'Pona',
        'Biomasa vegetal',
        totalBiomassO,
      ),
      BiomassData('Pona', 'Retención de carbono', resultCarbonBiomassO),
      BiomassData('Pona', 'Dióxido de carbono', resultConversionCarbonO),
      BiomassData('Pona', 'Total', sumaTotalO),

      //SSA
      BiomassData(
        'Ssa',
        'Biomasa vegetal',
        resultHerbaceousBiomassST,
      ),
      BiomassData('Pona', 'Retención de carbono', resultCarbonBiomassST),
      BiomassData('Pona', 'Dióxido de carbono', resultConversionCarbonST),
      BiomassData('Pona', 'Total', sumaTotalST),
    ];
  }

  //Variables de Aliso
  final double resultCarbonBiomass;
  final double totalBiomass;
  final double resultConversionCarbon;
  final double sumaTotal;
//Variables de ciprés
  final double resultCarbonBiomassC;
  final double totalBiomassC;
  final double resultConversionCarbonC;
  final double sumaTotalC;
//Variables de Pona
  final double resultCarbonBiomassO;
  final double totalBiomassO;
  final double resultConversionCarbonO;
  final double sumaTotalO;
//Variables de Pino
  final double resultCarbonBiomassP;
  final double totalBiomassP;
  final double resultConversionCarbonP;
  final double sumaTotalP;
//Variables de SSA
  final double resultCarbonBiomassST;
  final double resultHerbaceousBiomassST;
  final double resultConversionCarbonST;
  final double sumaTotalST;

  const ResultCarbonBiomassC(
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
      required this.resultConversionCarbonST,
      required this.sumaTotal,
      required this.sumaTotalC,
      required this.sumaTotalO,
      required this.sumaTotalP,
      required this.sumaTotalST});

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
    String level = getCarbonLevelC(resultCarbonBiomassC);
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
                            resultCarbonBiomass.toStringAsFixed(2),
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
                            resultCarbonBiomassC.toStringAsFixed(2),
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
                            resultCarbonBiomassP.toStringAsFixed(2),
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
                            resultCarbonBiomassO.toStringAsFixed(2),
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
                            resultCarbonBiomassST.toStringAsFixed(2),
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
                            totalBiomass.toStringAsFixed(2),
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
                            totalBiomassC.toStringAsFixed(2),
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
                            totalBiomassP.toStringAsFixed(2),
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
                            totalBiomassO.toStringAsFixed(2),
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
                            resultHerbaceousBiomassST.toStringAsFixed(2),
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
                            resultConversionCarbon.toStringAsFixed(2),
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
                            resultConversionCarbonC.toStringAsFixed(2),
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
                            resultConversionCarbonP.toStringAsFixed(2),
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
                            resultConversionCarbonO.toStringAsFixed(2),
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
                            resultConversionCarbonST.toStringAsFixed(2),
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
                    height: 380,
                    width: 280,

                    //Inicializamos el gráfico cartesiano
                    child: SfCartesianChart(
                      title: const ChartTitle(
                          text: 'Análisis de biomasa y retención de carbono \n'
                              'en Sistemas Silvopastoriles',
                          textStyle: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                      //Personalizando el eje x
                      primaryXAxis: CategoryAxis(
                        title: const AxisTitle(
                            text: 'Sistemas silvopastoriles',
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        axisLabelFormatter: (AxisLabelRenderDetails details) {
                          // Dividir las etiquetas largas en varias líneas
                          final text = details.text.replaceAll(' ', '\n');
                          return ChartAxisLabel(
                            text,
                            const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                          );
                        },
                      ),

                      //Personalizando el eje y
                      primaryYAxis: const NumericAxis(
                        title: AxisTitle(
                            text: 'T / ha',
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        interval: 50,
                        minimum: 0,
                        maximum: 4000,
                        majorGridLines: MajorGridLines(width: 1),
                      ),

                      legend: const Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.scroll,
                          position: LegendPosition.bottom,
                          alignment: ChartAlignment.center,
                          textStyle: TextStyle(fontSize: 12)),

                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        LineSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Aliso')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Aliso',
                          color: Colors.blue,
                          //Agregamos markers
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            color: Colors.blue,
                            borderWidth: 1,
                            borderColor: Colors.blue,
                          ),
                          //Números dentro del gráfico
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Text(
                                  data.value.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                        ),
                        LineSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Cipres')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Ciprés',
                          color: Colors.green,
                          //Agregamos markers
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            color: Colors.green,
                            borderWidth: 1,
                            borderColor: Colors.green,
                          ),
                          //Números dentro del gráfico
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Text(
                                  data.value.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                        ),
                        LineSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Pino')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Pino',
                          color: Colors.red,
                          //Agregamos markers
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            color: Colors.red,
                            borderWidth: 1,
                            borderColor: Colors.red,
                          ),
                          //Números dentro del gráfico
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Text(
                                  data.value.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                        ),
                        LineSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Pona')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Pona',
                          color: Colors.yellow,
                          //Agregamos markers
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            color: Colors.yellow,
                            borderWidth: 1,
                            borderColor: Colors.yellow,
                          ),
                          //Números dentro del gráfico
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Text(
                                  data.value.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                        ),
                        LineSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'SSA')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'SSA',
                          color: Colors.purple[900],
                          //Agregamos markers
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            color: Colors.purple,
                            borderWidth: 1,
                            borderColor: Colors.purple,
                          ),
                          //Números dentro del gráfico
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Text(
                                  data.value.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'El carbono total en la biomasa es de: ${resultCarbonBiomassC.toStringAsFixed(2)} T/ha',
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
                                builder: (context) =>
                                    const NewSelectSilvoScreen()));
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
