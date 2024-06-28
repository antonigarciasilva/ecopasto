/*import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

class CarbonData {
  final String category;
  final double value;

  CarbonData(this.category, this.value);
}

class CarbonChart extends StatelessWidget {
  final double resultCarbonBiomassO;

  const CarbonChart({super.key, required this.resultCarbonBiomassO});

  @override
  Widget build(BuildContext context) {
    //Creamos los datos
    List<CarbonData> data = [
      CarbonData('Bajo', resultCarbonBiomassO),
      CarbonData(
          'Medio',
          resultCarbonBiomassO >= 50 && resultCarbonBiomassO < 200
              ? resultCarbonBiomassO
              : 0),
      CarbonData(
          'Excelente', resultCarbonBiomassO >= 200 ? resultCarbonBiomassO : 0),
    ];

    //Configurar las opciones del gráfico
    var options = const ChartOptions();

    //Convertir los datos de un formato que flutter:chars pueda usar
    var chartData = ChartData(
      dataRows: [data.map((e) => e.value).toList()],
      xUserLabels: data.map((e) => e.category).toList(),
      dataRowsLegends: const ["Nivel de carbono"],
      chartOptions: options,
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Gráfica de nivel de carbono',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: LineChart(
              painter: LineChartPainter(
                chartData: chartData,
                chartOptions: ChartOptions,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/