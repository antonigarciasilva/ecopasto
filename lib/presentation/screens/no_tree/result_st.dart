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

class ResultSt extends StatelessWidget {
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
      BiomassData('Ssa', 'Retención de carbono', resultCarbonBiomassST),
      BiomassData('Ssa', 'Dióxido de carbono', resultConversionCarbonST),
      BiomassData('Ssa', 'Total', sumaTotalST),
    ];
  }

  //Funcion de boton informativo
  void openDialogInfo(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es la retención de carbono?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'La retención de carbono es cuando las plantas y el suelo capturan y almacenan dióxido de carbono (CO₂) del aire. En los sistemas silvopastoriles, que combinan árboles, pastos y ganado, se retiene más carbono que en sistemas sin árboles. Esto mejora la salud del suelo y ayuda a combatir el cambio climático al reducir la cantidad de CO₂ en la atmósfera, beneficiando tanto a la agricultura y al medio ambiente. \n'
                'Vásquez Pérez, H. V. (2023). ',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: const Text('Aceptar'))
              ],
            ));
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
    } else if (resultCarbonBiomassC < 100) {
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
    //responsive
    final size = MediaQuery.of(context).size;
    String level = getCarbonLevelC(resultHerbaceousBiomassST);
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
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.03),

                  SizedBox(
                      child: Image.asset(
                    getImagePath(level),
                    fit: BoxFit.fitHeight,
                    height: size.height * 0.45,
                  )),
                  SizedBox(height: size.height * 0.03),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
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
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: Text(
                            resultConversionCarbonST.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                      //Fila de la suma total
                      TableRow(children: [
                        Container(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        //Aliso
                        Container(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: Text(
                            sumaTotal.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Ciprés
                        Container(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: Text(
                            sumaTotalC.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Pino
                        Container(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: Text(
                            sumaTotalP.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Pona
                        Container(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: Text(
                            sumaTotalO.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //SSA
                        Container(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: Text(
                            sumaTotalST.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                    ],
                  ),

                  SizedBox(height: size.height * 0.03),
                  //Implementamos el gráfico

                  SizedBox(
                    height: size.height * 0.6,
                    width: size.width * 0.95,
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
                        interval: 20,
                        minimum: 0,
                        maximum: 250,
                        majorGridLines: MajorGridLines(width: 1),
                      ),

                      legend: const Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.scroll,
                          position: LegendPosition.bottom,
                          alignment: ChartAlignment.center,
                          textStyle: TextStyle(fontSize: 12)),

                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ColumnSeries>[
                        ColumnSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Aliso')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Aliso',
                          color: Colors.blue,
                          /*Agregamos markers
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            color: Colors.blue,
                            borderWidth: 1,
                            borderColor: Colors.blue,
                          ), */
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
                        ColumnSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Cipres')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Ciprés',
                          color: Colors.green,

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
                        ColumnSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Pino')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Pino',
                          color: Colors.red,

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
                        ColumnSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Pona')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Pona',
                          color: Colors.yellow,

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
                        ColumnSeries<BiomassData, String>(
                          dataSource: chartData
                              .where((data) => data.treeType == 'Ssa')
                              .toList(),
                          xValueMapper: (BiomassData data, _) => data.variable,
                          yValueMapper: (BiomassData data, _) => data.value,
                          name: 'Ssa',
                          color: Colors.purple[900],

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

                  SizedBox(height: size.height * 0.03),
                  Text(
                    'La retención de carbono en total es de: ${resultCarbonBiomassST.toStringAsFixed(2)} T/ha',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),

                  //Boton conocer más
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.white)),
                      onPressed: () => openDialogInfo(context),
                      child: const Text('Conocer más',
                          style: TextStyle(fontSize: 14, color: Colors.blue))),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    'Nivel de carbono: $level',
                    style: TextStyle(
                        fontSize: 21,
                        color: levelColor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    getRecommendationsC(level),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: size.height * 0.03),
                  Text(
                    getNextMeasuremetTimeC(level),
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: size.height * 0.03),

                  //Botón de regreso
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.green)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NewSelectSilvoScreen()));
                      },
                      child: const Text('Regresar',
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
