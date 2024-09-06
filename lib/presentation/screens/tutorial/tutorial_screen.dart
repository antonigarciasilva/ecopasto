import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:version/presentation/screens/select_system/new_select_silvo_screen.dart';

//Creamos nuestra clase poniendo lo que vamos a necesitar en los Slides
class SlideInfo {
  final String title;
  final String caption;
  final String imagenUrl;

  SlideInfo(this.title, this.caption, this.imagenUrl);
}

//Vamos a crear los slides

final slides = <SlideInfo>[
  SlideInfo(
      'Bienvenido a AmaSCarbon',
      'Una herramienta fácil y didactida para cuantificar el carbono en sistemas silvopastoriles (Pino, Pona, Ciprés y Aliso).',
      'assets/slides/silvipastoril.jpg'),
  SlideInfo(
      'Fácil de usar',
      'Con una interfaz intuitiva, nuestra aplicación móvil te guiará paso a paso en el proceso de cuantificación del carbono.',
      'assets/slides/agriapp.png'),
  SlideInfo(
      'Ingreso de datos',
      'Llena los datos solicitados de manera sencilla, siguiendo las instrucciones en pantalla.',
      'assets/slides/datos.png'),
  SlideInfo(
      'Secuencialidad',
      'Es importante llenar los datos en el orden indicado para obtener resultados precisos.',
      'assets/slides/secuencia.png'),
  SlideInfo(
      'Obtén tus resultados',
      'Una vez completado el ingreso de datos, obtendrás la cantidad de carbono en tu sistema silvopastoril.',
      'assets/slides/resultados.png'),
];

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  //el pageViewController va a recibir tipo de datos PageController()
  late final PageController pageViewController = PageController();
  //Creamos está variable para determinar que el usuario llega al final de los slides
  bool endReached = false;

  //Variable para el indice actual
  int currentIndex = 0;

  //Voy a inicializar con InitState que es parte de vida de los statefullwidget
  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      // ?? Sino estamos en una pagina especifica, entonces estamos en el slide 0
      final page = pageViewController.page ?? 0;
      //Para que se muestre un boton de comenzar en el último Slide se pone está condicional y
      //el endReach hace que solo se ejecute una sola vez
      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
      setState(() {
        //actualizar el indice actual
        currentIndex = page.round();
      });
    });
  }

//habilitar el dispose es buena práctica cuando hacemos uso de listener o controllador
//Es parte de vida del stateFulWidget
//pageViewController.dispose() limpia los listeners y ya no usamos memoria por las webas
  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //Se crea el boton de salida con el Stack
      body: Stack(
        children: [
          //Pageview usa toda la pantalla para trabajar
          PageView(
              controller: pageViewController,
              physics: const BouncingScrollPhysics(),
              //Se va a mostrar toda la info creada en la clase Slide, que pasa por el método privado _Slide, se va mostar en el body de PageView

              //Usamos el map porque queremos mostrar todo lo que tiene el _Slide
              children: slides
                  .map((slideData) => _Slide(
                      title: slideData.title,
                      caption: slideData.caption,
                      imagenUrl: slideData.imagenUrl))
                  .toList()),

          //Botton para salir de tutorial
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              child: const Text('Saltar'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewSelectSilvoScreen()));
              },
            ),
          ),

          //Aqui vamos a condicionar que el boton de comenzar aparezca al final de los Slides, en este caso,
          // no podemos hacerlo null, entonces, se pondrá un SizedBox que es un widget para no mostrar nada hasta que la condición se cumpla.
          if (endReached)
            Positioned(
              left: 0,
              right: 0,
              bottom: 45,
              //Con la librería animated_do, para mejora vista al buttum, va a salir por la deracha después de un segundo
              child: FadeInRight(
                //from:15 se moverá 15 unidades y de 1 seg en mostrarse
                from: 15,
                delay: const Duration(seconds: 1),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NewSelectSilvoScreen()));
                      },
                      child: const Text('Comenzar')),
                ),
              ),
            )
          else
            const SizedBox(),

          //Barra de progreso
          Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    slides.length,
                    (index) => Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == currentIndex
                                ? Colors.blue
                                : Colors.grey.withOpacity(0.5),
                          ),
                        )),
              ))
        ],
      ),
    );
  }
}

//Creamos otro Stles widget para recibir toda la data de los slides que se creo primero

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imagenUrl;
  const _Slide(
      {required this.title, required this.caption, required this.imagenUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(imagenUrl)),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              caption,
              style: captionStyle,
            )
          ],
        ),
      ),
    );
  }
}
