import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/aliso_screen.dart';
import 'package:version/presentation/screens/cipres_screen.dart';
import 'package:version/presentation/screens/no_tree_screen.dart';
import 'package:version/presentation/screens/pino_screen.dart';
import 'package:version/presentation/screens/pona_screen.dart';

class NewSelectSilvoScreen extends StatelessWidget {
  const NewSelectSilvoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seleciona un Sistemas \n'
          'Silvipastoril',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child:
            ListView(physics: const BouncingScrollPhysics(), children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 160.0,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                //Pino
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PinoScreen()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(children: [
                        Image.asset(
                          'assets/img/pino.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(6),
                              color: Colors.white.withOpacity(0.5),
                              child: const Text(
                                'Pino',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      ]),
                    ),
                  ),
                ),

                //Cipres
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CipresScreen()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(children: [
                        Image.asset(
                          'assets/img/cipres.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(6),
                              color: Colors.white.withOpacity(0.5),
                              child: const Text(
                                'Cipres',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      ]),
                    ),
                  ),
                ),

                //Aliso
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AlisoScreen()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(children: [
                        Image.asset(
                          'assets/img/aliso.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(6),
                              color: Colors.white.withOpacity(0.5),
                              child: const Text(
                                'Aliso',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      ]),
                    ),
                  ),
                ),

                //Pona
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PonaScreen()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(children: [
                        Image.asset(
                          'assets/img/pona.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(6),
                              color: Colors.white.withOpacity(0.5),
                              child: const Text(
                                'Pona',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      ]),
                    ),
                  ),
                ),

                //Sin arboles
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NoTreeScreen()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/img/sin_pasto.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                                padding: const EdgeInsets.all(6),
                                color: Colors.white.withOpacity(0.4),
                                child: const Text(
                                  'Sin Arboles',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 40,
          ),
          //todo Concepto
          const ExpansionTile(
            leading: Icon(Icons.forest_outlined),
            title: Text('¿Qué es un sistema silvopastoril?'),
            //subtitle: Text('Un sistema silvopastoril es...'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Text(
                  'Un sistema silvopastoril es una forma de uso de la tierra en la cual se integran árboles, pastos y animales en una misma unidad de producción.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          //todo objetivo
          const ExpansionTile(
            leading: Icon(Icons.flag_outlined),
            title: Text('Objetivo'),
            //subtitle: Text('Un sistema silvopastoril es...'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Text(
                  'Utilizar de manera eficiente la tierra, maximizando la producción de alimentos, fibras y madera, al tiempo que se conservan los recursos naturales y se protege el medio ambiente.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          //Todo Ventajas
          const ExpansionTile(
            leading: Icon(Icons.check_box_outlined),
            title: Text('Ventajas'),
            //subtitle: Text('Un sistema silvopastoril es...'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Text(
                  '- Mejora la productividad del suelo.\n'
                  '- Aumenta la biodiversidad.\n'
                  '- Ayuda a la conservación del suelo y del agua.\n'
                  '- Reduce la dependencia de insumos externos.\n'
                  '- Contribuye a la mitigación del cambio climático.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          //todo Importancia
          const ExpansionTile(
            leading: Icon(Icons.auto_graph_sharp),
            title: Text('Importancia'),
            //subtitle: Text('Un sistema silvopastoril es...'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Text(
                  'Los sistemas silvopastoriles son fundamentales para la producción agropecuaria sostenible, ya que permiten obtener múltiples beneficios económicos, sociales y ambientales al mismo tiempo.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
