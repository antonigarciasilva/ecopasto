import 'package:flutter/material.dart';

class SoilCarbonScreen extends StatelessWidget {
  const SoilCarbonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/img/biomas_alder.jpg',
                    fit: BoxFit.fitWidth,
                    height: 259,
                  ),
                ),

                //Título
                const SizedBox(height: 25.0),
                const Text(
                  'Calculando carbono en el suelo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //Formula
                const SizedBox(height: 25.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Ws (t/ha) = a * p * da',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Día de evaluación
                const SizedBox(height: 20.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Día de evaluación: ',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                    SizedBox(width: 20),
                  ],
                ),

                //Área
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'a: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 79,
                      height: 25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'cm',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),

                //Profundidad
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'p: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 79,
                      height: 25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'm',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),

                //PST
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'da: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 79,
                      height: 25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'kg/m3',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),

                //NOTA
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nota: \n'
                        '*Ws: Peso del suelo (t/ha) \n'
                        '*a: Área (ha) \n'
                        '*p: Profundidad (m) \n'
                        '*da: Densidad aparente del suelo \n',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),

                //Guardar
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SoilCarbonScreen()),
                        );
                      },
                      child: const Text(
                        'Calcular',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
