import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/select_system/new_select_silvo_screen.dart';

import 'package:version/presentation/screens/ubicacion/ubicacion.dart';

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

class ResultCarbonBiomass extends StatefulWidget {
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
    required this.sumaTotal,
    required this.sumaTotalC,
    required this.sumaTotalO,
    required this.sumaTotalP,
    required this.sumaTotalST,
  });

  @override
  State<ResultCarbonBiomass> createState() => _ResultCarbonBiomassState();
}

class _ResultCarbonBiomassState extends State<ResultCarbonBiomass>
    with WidgetsBindingObserver {
  //llamamos al statebiomass
  final StateBiomass _stateBiomass = StateBiomass();

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
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //Preparamos las listas para el gráfico
  List<BiomassData> getchartDate() {
    return [
      //Aliso
      BiomassData(
        'Aliso',
        'Biomasa vegetal',
        widget.totalBiomass,
      ),
      BiomassData('Aliso', 'Retención de carbono', widget.resultCarbonBiomass),
      BiomassData('Aliso', 'Dióxido de carbono', widget.resultConversionCarbon),
      BiomassData('Aliso', 'Total', widget.sumaTotal),

      //Ciprés
      BiomassData(
        'Cipres',
        'Biomasa vegetal',
        widget.totalBiomassC,
      ),
      BiomassData(
          'Cipres', 'Retención de carbono', widget.resultCarbonBiomassC),
      BiomassData(
          'Cipres', 'Dióxido de carbono', widget.resultConversionCarbonC),
      BiomassData('Cipres', 'Total', widget.sumaTotalC),

      //Pino
      BiomassData(
        'Pino',
        'Biomasa vegetal',
        widget.totalBiomassP,
      ),
      BiomassData('Pino', 'Retención de carbono', widget.resultCarbonBiomassP),
      BiomassData('Pino', 'Dióxido de carbono', widget.resultConversionCarbonP),
      BiomassData('Pino', 'Total', widget.sumaTotalP),
      //Pona
      BiomassData(
        'Pona',
        'Biomasa vegetal',
        widget.totalBiomassO,
      ),
      BiomassData('Pona', 'Retención de carbono', widget.resultCarbonBiomassO),
      BiomassData('Pona', 'Dióxido de carbono', widget.resultConversionCarbonO),
      BiomassData('Pona', 'Total', widget.sumaTotalO),

      //SSA
      BiomassData(
        'Ssa',
        'Biomasa vegetal',
        widget.resultHerbaceousBiomassST,
      ),
      BiomassData('Ssa', 'Retención de carbono', widget.resultCarbonBiomassST),
      BiomassData('Ssa', 'Dióxido de carbono', widget.resultConversionCarbonST),
      BiomassData('Ssa', 'Total', widget.sumaTotalST),
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
                '(Vásquez, 2023).',
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

  //Vamos a definir los rangos
  String getCarbonLevel(double resultCarbonBiomass) {
    if (resultCarbonBiomass < 50) {
      return 'Bajo';
    } else if (resultCarbonBiomass < 100) {
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
    //responsive
    final size = MediaQuery.of(context).size;
    String level = getCarbonLevel(widget.resultCarbonBiomass);
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
                                  widget.resultCarbonBiomass.toStringAsFixed(2),
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
                                  widget.resultCarbonBiomassC
                                      .toStringAsFixed(2),
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
                                  widget.resultCarbonBiomassP
                                      .toStringAsFixed(2),
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
                                  widget.resultCarbonBiomassO
                                      .toStringAsFixed(2),
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
                                  widget.resultCarbonBiomassST
                                      .toStringAsFixed(2),
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
                                  widget.totalBiomass.toStringAsFixed(2),
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
                                  widget.totalBiomassC.toStringAsFixed(2),
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
                                  widget.totalBiomassP.toStringAsFixed(2),
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
                                  widget.totalBiomassO.toStringAsFixed(2),
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
                                  widget.resultHerbaceousBiomassST
                                      .toStringAsFixed(2),
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
                                  widget.resultConversionCarbon
                                      .toStringAsFixed(2),
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
                                  widget.resultConversionCarbonC
                                      .toStringAsFixed(2),
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
                                  widget.resultConversionCarbonP
                                      .toStringAsFixed(2),
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
                                  widget.resultConversionCarbonO
                                      .toStringAsFixed(2),
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
                                  widget.resultConversionCarbonST
                                      .toStringAsFixed(2),
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
                                  widget.sumaTotal.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              //Ciprés
                              Container(
                                padding: EdgeInsets.all(size.width * 0.01),
                                child: Text(
                                  widget.sumaTotalC.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              //Pino
                              Container(
                                padding: EdgeInsets.all(size.width * 0.01),
                                child: Text(
                                  widget.sumaTotalP.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              //Pona
                              Container(
                                padding: EdgeInsets.all(size.width * 0.01),
                                child: Text(
                                  widget.sumaTotalO.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              //SSA
                              Container(
                                padding: EdgeInsets.all(size.width * 0.01),
                                child: Text(
                                  widget.sumaTotalST.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
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
                                text:
                                    'Análisis de biomasa y retención de carbono \n'
                                    'en Sistemas Silvopastoriles',
                                textStyle: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold)),
                            //Personalizando el eje x
                            primaryXAxis: CategoryAxis(
                              title: const AxisTitle(
                                  text: 'Sistemas silvopastoriles',
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              axisLabelFormatter:
                                  (AxisLabelRenderDetails details) {
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              interval: 10,
                              minimum: 0,
                              maximum: 250,
                              majorGridLines: MajorGridLines(
                                width: 1,
                              ),
                            ),

                            legend: const Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.scroll,
                                position: LegendPosition.bottom,
                                alignment: ChartAlignment.center,
                                textStyle: TextStyle(fontSize: 12)),

                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                            ),
                            series: <ColumnSeries>[
                              ColumnSeries<BiomassData, String>(
                                dataSource: chartData
                                    .where((data) => data.treeType == 'Aliso')
                                    .toList(),
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
                                name: 'Aliso',
                                color: Colors.blue,
                                /*Agregamos markers
                                markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  shape: DataMarkerType.circle,
                                  color: Colors.blue,
                                  borderWidth: 0.5,
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
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
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
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
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
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
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
                                xValueMapper: (BiomassData data, _) =>
                                    data.variable,
                                yValueMapper: (BiomassData data, _) =>
                                    data.value,
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
                          'La retención de carbono en total es de: ${widget.resultCarbonBiomass.toStringAsFixed(2)} T/ha',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),

                        SizedBox(height: size.height * 0.03),
                        //Boton de conocer más
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white)),
                            onPressed: () => openDialogInfo(context),
                            child: const Text('Conocer más',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blue))),
                        SizedBox(height: size.height * 0.03),
                        //Nivel de carbono
                        Text(
                          'Nivel de carbono: $level',
                          style: TextStyle(
                              fontSize: 21,
                              color: levelColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                        //Recomendaciones
                        SizedBox(height: size.height * 0.03),
                        Text(
                          getRecommendations(level),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                        //boton de google maps
                        SizedBox(height: size.height * 0.03),
                        LocationPage(stateBiomass: _stateBiomass),

                        //Proximo en medir
                        SizedBox(height: size.height * 0.03),
                        Text(
                          getNextMeasuremetTime(level),
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: size.height * 0.03),

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
                            child: const Text('Regresar',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)))
                      ])),
            ),
          ),
        ));
  }
}
