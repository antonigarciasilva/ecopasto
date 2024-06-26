import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/carbon/carbon.dart';

class ResultCarbonBiomass extends StatelessWidget {
  final double resultCarbonBiomass;

  const ResultCarbonBiomass({super.key, required this.resultCarbonBiomass});

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

  @override
  Widget build(BuildContext context) {
    String level = getCarbonLevel(resultCarbonBiomass);
    Color levelColor;

    if (level == 'Bajo') {
      levelColor = Colors.red;
    } else if (level == 'Medio') {
      levelColor = Colors.yellow;
    } else {
      levelColor = Colors.green;
    }
    return Scaffold(
        appBar: AppBar(title: const Text('Resultado del cálculo')),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Text(
                  'El carbono total en la biomasa es de: ${resultCarbonBiomass.toStringAsFixed(2)} Tn/Ha',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nivel de carbono: $level',
                  style: TextStyle(fontSize: 24, color: levelColor),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  getRecommendations(level),
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  getNextMeasuremetTime(level),
                  style: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.justify,
                ),

                //Boton de aceptar
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarbonScreen()));
                    },
                    child: const Text('Aceptar'))
              ])),
        ));
  }
}
