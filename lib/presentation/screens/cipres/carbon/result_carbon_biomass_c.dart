import 'package:flutter/material.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';

class ResultCarbonBiomassC extends StatelessWidget {
  final double resultCarbonBiomassC;
  const ResultCarbonBiomassC({super.key, required this.resultCarbonBiomassC});

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
                'El carbono total en la biomasa es de: ${resultCarbonBiomassC.toStringAsFixed(2)} Tn/ha',
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
