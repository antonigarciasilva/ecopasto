import 'package:flutter/material.dart';

import 'package:version/presentation/screens/aliso/aliso_screen.dart';
import 'package:version/presentation/screens/cipres_screen.dart';
import 'package:version/presentation/screens/no_tree_screen.dart';

import 'package:version/presentation/screens/pino_screen.dart';
import 'package:version/presentation/screens/pona_screen.dart';
/*
class SelectSilvoSystem extends StatelessWidget {
  const SelectSilvoSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecciona una sistema silvipastoril',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildImageItem(
                  context,
                  'assets/img/pino.jpg',
                  'Pino',
                  const PinoScreen(),
                ),
                const SizedBox(
                  width: 15,
                ),
                _buildImageItem(
                  context,
                  'assets/img/cipres.jpg',
                  'Cipres',
                  const CipresScreen(),
                ),
                const SizedBox(
                  width: 15,
                ),
                _buildImageItem(
                  context,
                  'assets/img/aliso.jpg',
                  'Aliso',
                  const AlisoScreen(),
                ),
                const SizedBox(
                  width: 15,
                ),
                _buildImageItem(
                  context,
                  'assets/img/pona.jpg',
                  'Pona',
                  const PonaScreen(),
                ),
                const SizedBox(
                  width: 15,
                ),
                _buildImageItem(
                  context,
                  'assets/img/sin_pasto.jpg',
                  'Sin arboles',
                  const NoTreeScreen(),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '¿Qué es un sistema silvopastoril?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Un sistema silvopastoril es una forma de uso de la tierra en la cual se integran árboles, pastos y animales en una misma unidad de producción. Su objetivo principal es mejorar la productividad de la tierra de forma sostenible, aprovechando al máximo los recursos disponibles.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Objetivo:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Utilizar de manera eficiente la tierra, maximizando la producción de alimentos, fibras y madera, al tiempo que se conservan los recursos naturales y se protege el medio ambiente.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Ventajas:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '- Mejora la productividad del suelo.\n'
                  '- Aumenta la biodiversidad.\n'
                  '- Ayuda a la conservación del suelo y del agua.\n'
                  '- Reduce la dependencia de insumos externos.\n'
                  '- Contribuye a la mitigación del cambio climático.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Importancia:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Los sistemas silvopastoriles son fundamentales para la producción agropecuaria sostenible, ya que permiten obtener múltiples beneficios económicos, sociales y ambientales al mismo tiempo.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageItem(
      BuildContext context, String imagePath, String label, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
        const SizedBox(
          width: 15,
        );
      },
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.asset(
                  imagePath,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


Para cargar el loading 

const Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
              ),
*/

class SelectSilvoSystem extends StatelessWidget {
  const SelectSilvoSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecciona una sistema silvipastoril',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        centerTitle: true,
      ),

      //Todo el cuerpo para comprender mejor
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PinoScreen()),
              );
            },
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    'assets/img/pino.jpg',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  'Pino',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CipresScreen()),
              );
            },
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset('assets/img/cipres.jpg',
                      height: 150, width: 150, fit: BoxFit.cover),
                ),
                const Text(
                  'Cipres',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlisoScreen()),
              );
            },
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset('assets/img/aliso.jpg',
                      height: 150, width: 150, fit: BoxFit.cover),
                ),
                const Text(
                  'Aliso',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PonaScreen()),
                );
              },
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.asset('assets/img/pona.jpg',
                        height: 150, width: 150, fit: BoxFit.cover),
                  ),
                  const Text(
                    'Pona',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoTreeScreen()),
              );
            },
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset('assets/img/sin_pasto.jpg',
                      height: 150, width: 150, fit: BoxFit.cover),
                ),
                const Text(
                  'Sin arboles',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //Contenedor para parrafo
    );
  }
}
