import 'package:flutter/material.dart';

import 'package:version/presentation/screens/pona/carbon/carbon_pona.dart';

class ResultCarbonBiomassO extends StatelessWidget {
  final double resultCarbonBiomassO;
  const ResultCarbonBiomassO({super.key, required this.resultCarbonBiomassO});

  @override
  Widget build(BuildContext context) {
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
                'El carbono total en la biomasa es de: ${resultCarbonBiomassO.toStringAsFixed(2)} Tn/ha',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarbonPonaScreen()));
                  },
                  child: const Text('Aceptar'))
            ],
          ),
        ),
      ),
    );
  }
}
