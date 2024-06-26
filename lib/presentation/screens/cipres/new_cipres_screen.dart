import 'package:flutter/material.dart';

import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';
import 'package:version/presentation/screens/cipres/dry_matter_c.dart';
import 'package:version/presentation/screens/cipres/green_matter_c.dart';
import 'package:version/presentation/screens/widgets/side_menu.dart';

class NewCipresScreen extends StatefulWidget {
  const NewCipresScreen({super.key});

  @override
  State<NewCipresScreen> createState() => _NewCipresScreenState();
}

class _NewCipresScreenState extends State<NewCipresScreen> {
  final List<bool> _completedTasks = [false, false, false, false];

  void _completeTask(int index) {
    setState(() {
      _completedTasks[index] = true;
    });
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es el Ciprés?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'El árbol de ciprés (Cupressus spp.) en sistemas silvopastoriles es una especie de árbol conífero que se utiliza por su rápido crecimiento y su capacidad para proporcionar sombra y protección contra el viento. También puede ayudar a reducir la erosión del suelo y mejorar la biodiversidad en la zona.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Silvopastoreo con Ciprés',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const SideMenu(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/cipres/cypress.jpg',
                      fit: BoxFit.fitWidth,
                      height: 299,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 10,
                    child: FilledButton.tonal(
                      onPressed: () => openDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),

                // Botón 1: Materia verde
                const SizedBox(height: 20.0),
                _buildButton(
                  context,
                  0,
                  '1. Materia verdeverde',
                  const GreenMatterC(),
                ),

                // Botón 2: Materia seca
                const SizedBox(height: 20.0),
                _buildButton(
                  context,
                  1,
                  '2. Materia seca',
                  const DryMatterC(),
                ),

                // Botón 3: Biomasa
                const SizedBox(height: 20.0),
                _buildButton(
                  context,
                  2,
                  '3. Biomasa',
                  const BiomassScreenC(),
                ),

                // Botón 4: Carbono en la biomasa
                const SizedBox(height: 20.0),
                _buildButton(
                  context,
                  3,
                  '4. Carbono en la biomasa',
                  const CarbonScreenC(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, int index, String title, Widget targetScreen) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        width: 260,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: _completedTasks[index]
                ? WidgetStateProperty.all<Color>(Colors.grey)
                : WidgetStateProperty.all<Color>(
                    const Color.fromARGB(255, 51, 79, 31)),
          ),
          onPressed: _completedTasks[index]
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => targetScreen),
                  ).then((_) => _completeTask(index));
                },
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
