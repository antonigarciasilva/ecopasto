import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/aliso_screen.dart';
import 'package:version/presentation/screens/cipres/cipres_screen.dart';
import 'package:version/presentation/screens/pino/pino_screen.dart';
import 'package:version/presentation/screens/pona/pona_screen.dart';
import 'package:version/presentation/screens/select_system/new_select_silvo_screen.dart';
import 'package:version/presentation/screens/tutorial/tutorial_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  //Para saber que pantalla vamos a coger

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    //Código para ver cuanto espacio hay desde el top hasta donde comienza el menú
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    /*if (Platform.isAndroid) {
      print('Android $hasNotch');
    }¨*/

    //Esto es para que se quede seleccionado el boton cuando le das click
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
      },
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text(
              'Menú principal',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 82, 12, 7)),
            )),

        //Selecciona nuevo sistemas silvopastoril
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(Icons.anchor_sharp),
          title: const Text('Selec. sistema silvopastoril'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewSelectSilvoScreen()));
          },
        ),

        //Aliso
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(Icons.energy_savings_leaf_rounded),
          title: const Text('Aliso'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AlisoScreen()));
          },
        ),

        //Pino
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(Icons.directions_transit_filled_rounded),
          title: const Text('Pino'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PinoScreen()));
          },
        ),

        //Ciprés
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(Icons.temple_buddhist_rounded),
          title: const Text('Ciprés'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CipresScreen()));
          },
        ),

        //Pona
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(Icons.terrain_rounded),
          title: const Text('Pona'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PonaScreen()));
          },
        ),

        /*const NavigationDrawerDestination(
            icon: Icon(Icons.safety_check), label: Text('bays')), */

        //Linea que divide
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        //Más opciones
        Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text(
              'Más opciones',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 82, 12, 7)),
            )),

        //Tutorial
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(Icons.thumb_up_alt_rounded),
          title: const Text('Tutorial'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TutorialScreen()));
          },
        ),

        //Informativo
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(Icons.info),
          title: const Text('¿Qué es un Sistema silvopastoril?'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewSelectSilvoScreen()));
          },
        ),
      ],
    );
  }
}
