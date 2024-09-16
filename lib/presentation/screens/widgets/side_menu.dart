import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/aliso_screen.dart';
import 'package:version/presentation/screens/cipres/cipres_screen.dart';
import 'package:version/presentation/screens/no_tree/no_tree_screen.dart';
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
    final size = MediaQuery.of(context).size;

    //Esto es para que se quede seleccionado el boton cuando le das click
    return NavigationDrawer(
      backgroundColor: Colors.white,
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
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),

        //Linea que divide
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 3, 28, 10),
          child: Divider(),
        ),

        //Selecciona nuevo sistemas silvopastoril
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(
            Icons.nature_people,
            color: Colors.black,
          ),
          title: const Text(
            'Seleccione un sistema silvopastoril',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
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
          leading: const Icon(
            Icons.eco_rounded,
            color: Colors.black,
          ),
          title: const Text(
            'Aliso',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AlisoScreen()));
          },
        ),

        //Pino
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(
            Icons.park,
            color: Colors.black,
          ),
          title: const Text(
            'Pino',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PinoScreen()));
          },
        ),

        //Ciprés
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(
            Icons.forest,
            color: Colors.black,
          ),
          title: const Text(
            'Ciprés',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CipresScreen()));
          },
        ),

        //Pona
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(
            Icons.nature,
            color: Colors.black,
          ),
          title: const Text(
            'Pona',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PonaScreen()));
          },
        ),

        //Pastizal
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(
            Icons.grass,
            color: Colors.black,
          ),
          title: const Text(
            'Pastizal',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NoTreeScreen()));
          },
        ),

        SizedBox(
          height: size.height * 0.01,
        ),

        //Más opciones
        Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text(
              'Más opciones',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),

        //Linea que divide
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 3, 28, 10),
          child: Divider(),
        ),

        //Tutorial
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
          leading: const Icon(
            Icons.school_sharp,
            color: Colors.black,
          ),
          title: const Text(
            'Tutorial',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
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
          leading: const Icon(
            Icons.info,
            color: Colors.black,
          ),
          title: const Text(
            '¿Qué es un Sistema silvopastoril?',
            style: TextStyle(color: Colors.black),
          ),
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
