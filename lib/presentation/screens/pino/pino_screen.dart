import 'package:flutter/material.dart';
import 'package:version/presentation/screens/pino/biomass/biomass.dart';
import 'package:version/presentation/screens/pino/carbon/carbon.dart';
import 'package:version/presentation/screens/pino/dry_matter_p.dart';
import 'package:version/presentation/screens/pino/green_matter_p.dart';

class PinoScreen extends StatelessWidget {
  const PinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/img/pino/pino.jpg',
                  fit: BoxFit.fitWidth,
                  height: 299,
                ),
              ),

              //Título
              //const SizedBox(height: 5.0),
              const Text(
                'Silvipastoreo con Pino',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //Materia verde
              const SizedBox(height: 20.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: 260,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GreenMatterP()),
                      );
                    },
                    child: const Text(
                      '1. Materia verde',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              //Materia seca
              const SizedBox(height: 20.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: 260,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DryMatterP()),
                      );
                    },
                    child: const Text(
                      '2. Materia seca',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              //Biomasa
              const SizedBox(height: 20.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: 260,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BiomassPinoScreen()),
                      );
                    },
                    child: const Text(
                      ' 3. Biomasa',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              //Carbono en la biomasa
              const SizedBox(height: 20.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: 260,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarbonPinoScreen()),
                      );
                    },
                    child: const Text(
                      '4. Carbono en la biomasa',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
