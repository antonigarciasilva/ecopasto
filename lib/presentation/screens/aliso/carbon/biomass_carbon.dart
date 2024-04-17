import 'package:flutter/material.dart';

class BiomassCarbonScreen extends StatelessWidget {
  const BiomassCarbonScreen({super.key});

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
                const SizedBox(height: 10.0),
                const Text(
                  'Calculando carbono en la biomasa con Aliso',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                //Formula
                const SizedBox(height: 15.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'CBV(t/ha): BVT * fracción de carbono',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //NOTA
                //const SizedBox height: 10,),
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*CBV: Carbono en biomasa vegetal(t/ha) \n'
                        '*BVT: Biomasa vegetal total\n'
                        '*0.4270: Fracción de carbono de Aliso \n',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
                //Día de evaluación
                //const SizedBox(height: 1.0),
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

                //BVT
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'BVT: ',
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
                          labelText: 'gramos',
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),

                //Calcular
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
                              builder: (context) =>
                                  const BiomassCarbonScreen()),
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
