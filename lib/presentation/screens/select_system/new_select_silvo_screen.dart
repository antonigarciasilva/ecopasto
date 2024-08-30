import 'package:flutter/material.dart';

import 'package:version/presentation/screens/aliso/aliso_screen.dart';
import 'package:version/presentation/screens/cipres/cipres_screen.dart';

import 'package:version/presentation/screens/no_tree/no_tree_screen.dart';
import 'package:version/presentation/screens/pino/pino_screen.dart';
import 'package:version/presentation/screens/pona/pona_screen.dart';
import 'package:version/presentation/screens/widgets/side_menu.dart';

class NewSelectSilvoScreen extends StatelessWidget {
  const NewSelectSilvoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Seleciona un Sistemas \n'
          'Silvopastoril',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      drawer: const SideMenu(),
      body: SafeArea(
        child: Center(
          child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                //top
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 280.0,
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
                                'assets/img/pino/pino.jpg',
                                height: 280,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  color: Colors.white.withOpacity(0.7),
                                  child: const Text.rich(
                                    TextSpan(
                                        text: 'Pinus sylvestris ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '(Pino)',
                                            style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                            ),
                                          )
                                        ]),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                                    builder: (context) =>
                                        const CipresScreen()));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Stack(children: [
                              Image.asset(
                                'assets/img/cipres/cipres.jpg',
                                height: 280,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  color: Colors.white.withOpacity(0.7),
                                  child: const Text.rich(
                                    TextSpan(
                                        text: 'Cupressus ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '(Ciprés)',
                                            style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                            ),
                                          )
                                        ]),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                                'assets/img/aliso/aliso_verde.jpg',
                                height: 280,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  color: Colors.white.withOpacity(0.7),
                                  child: const Text.rich(
                                    TextSpan(
                                        text: 'Alnus glutinosa ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '(Aliso)',
                                            style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                            ),
                                          )
                                        ]),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                                'assets/img/pona/pona.jpg',
                                height: 280,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  color: Colors.white.withOpacity(0.7),
                                  child: const Text.rich(
                                    TextSpan(
                                        text: 'Socratea exorrhiza ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '(Pona)',
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                              ))
                                        ]),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                                    builder: (context) =>
                                        const NoTreeScreen()));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/img/sinarbol/sin_pasto.jpg',
                                  height: 280,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                      padding: const EdgeInsets.all(6),
                                      color: Colors.white.withOpacity(0.7),
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
                  height: 30,
                ),
                //todo Concepto
                const ExpansionTile(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  //collapsedIconColor: Colors.green,

                  //tilePadding: EdgeInsets.zero,

                  // collapsedBackgroundColor: Color.fromARGB(255, 188, 247, 122),
                  //backgroundColor: Color.fromARGB(255, 238, 248, 238),
                  leading: Icon(Icons.forest_outlined),
                  title: Text(
                    '¿Qué es un sistema silvopastoril?',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                  ),
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
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  //collapsedIconColor: Colors.green,
                  leading: Icon(Icons.flag_outlined),
                  //collapsedBackgroundColor: Color.fromARGB(255, 188, 247, 122),
                  //backgroundColor: Color.fromARGB(255, 238, 248, 238),
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
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  //collapsedIconColor: Colors.green,
                  leading: Icon(Icons.check_box_outlined),
                  //collapsedBackgroundColor: Color.fromARGB(255, 188, 247, 122),
                  // backgroundColor: Color.fromARGB(255, 238, 248, 238),
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
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  // collapsedIconColor: Colors.green,
                  // collapsedBackgroundColor: Color.fromARGB(255, 188, 247, 122),
                  // backgroundColor: Color.fromARGB(255, 238, 248, 238),
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
      ),
    );
  }
}
