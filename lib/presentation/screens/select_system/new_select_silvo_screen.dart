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
    //Variable para hacer resposivo
    final size = MediaQuery.of(context).size;
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
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  height: size.height * 0.5,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
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
                                'assets/img/pona/greenmatter/green_o.jpg',
                                height: size.height * 0.5,
                                width: size.width * 0.8,
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
                                        text: 'Pona',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '(Ceroxilum quindiuense)',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
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
                                height: size.height * 0.5,
                                width: size.width * 0.8,
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
                                        text: 'Ciprés',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '(Cupressus macrocarpa)',
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
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
                                'assets/img/pino/pino_screen.jpg',
                                height: size.height * 0.5,
                                width: size.width * 0.8,
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
                                        text: 'Pino',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '(Pinus patula)',
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
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
                                'assets/img/aliso/aliso_select.jpg',
                                height: size.height * 0.5,
                                width: size.width * 0.8,
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
                                        text: 'Aliso',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '(Alnus acuminata)',
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
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
                                  'assets/img/sinarbol/pastizal.jpg',
                                  height: size.height * 0.5,
                                  width: size.width * 0.8,
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
                                        'Sin Árboles',
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

                SizedBox(
                  height: size.height * 0.03,
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
                      padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                      child: Text(
                        'Un sistema silvopastoril (SSP) es un modelo de manejo agropecuario que combina árboles, pastos y animales para mejorar la producción y contribuir al medio ambiente, capturando carbono y conservando la biodiversidad. \n'
                        '(Vásquez, 2023)',
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
                      padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                      child: Text(
                        'Mejorar la productividad ganadera y la sostenibilidad ambiental, capturando carbono, recuperando suelos degradados y protegiendo la biodiversidad. \n'
                        '(Vásquez, 2023)',
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
                      padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                      child: Text(
                        '- Mejora la productividad del suelo.\n'
                        '- Aumentan la eficiencia productiva de la ganadería.\n'
                        '- Incrementan la biodiversidad.\n'
                        '- Reduce la dependencia de insumos externos.\n'
                        '- Contribuye a la mitigación del cambio climático.\n'
                        '(Vásquez, 2023)',
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
                      padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                      child: Text(
                        'Los sistemas silvopastoriles son importantes porque ayudan a mitigar el cambio climático, recuperan ecosistemas degradados y mejoran la biodiversidad y la fertilidad del suelo.\n'
                        '(Vásquez, 2023)',
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
