import 'package:flutter/material.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';

class ResultCarbonBiomassC extends StatelessWidget {
  final double resultCarbonBiomassC;
  const ResultCarbonBiomassC({super.key, required this.resultCarbonBiomassC});

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

  @override
  Widget build(BuildContext context) {
    String level = getCarbonLevelC(resultCarbonBiomassC);
    Color levelColor;

    if (level == 'Bajo') {
      levelColor = Colors.red;
    } else if (level == 'Medio') {
      levelColor = Colors.yellow;
    } else {
      levelColor = Colors.green;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado de cálculo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'El carbono total en la biomasa es de: ${resultCarbonBiomassC.toStringAsFixed(2)} Tn/ha',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
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
                getRecommendationsC(level),
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(
                height: 20,
              ),
              Text(
                getNextMeasuremetTimeC(level),
                style:
                    const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ),

              //Botón de regreso
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarbonScreenC()));
                  },
                  child: const Text('Aceptar'))
            ],
          ),
        ),
      ),
    );
  }
}
