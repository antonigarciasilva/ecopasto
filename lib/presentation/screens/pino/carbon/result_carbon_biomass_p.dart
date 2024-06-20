import 'package:flutter/material.dart';
import 'package:version/presentation/screens/pino/carbon/carbon.dart';

class ResultCarbonBiomassP extends StatelessWidget {
  final double resultCarbonBiomassP;
  const ResultCarbonBiomassP({super.key, required this.resultCarbonBiomassP});

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
                'El carbono total en la biomasa es de: ${resultCarbonBiomassP.toStringAsFixed(2)} Tn/ha',
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
                            builder: (context) => const CarbonPinoScreen()));
                  },
                  child: const Text('Aceptar'))
            ],
          ),
        ),
      ),
    );
  }
}
