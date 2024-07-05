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
                                          const CarbonScreen()));
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
