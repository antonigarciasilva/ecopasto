import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/carbon/carbon.dart';

class ResultCarbonBiomass extends StatelessWidget {
  final double resultCarbonBiomass;
  const ResultCarbonBiomass({super.key, required this.resultCarbonBiomass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Resultado del cálculo')),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Text(
                    'El carbono total en la biomasa es de: ${resultCarbonBiomass.toStringAsFixed(2)} Tn/Ha'),
                const SizedBox(
                  height: 20,
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
