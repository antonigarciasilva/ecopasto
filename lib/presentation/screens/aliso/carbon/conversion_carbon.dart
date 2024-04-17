import 'package:flutter/material.dart';

class ConversionCarbonScreen extends StatelessWidget {
  const ConversionCarbonScreen({super.key});

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
                  'Conversión de carbono orgánico a dióxido de carbono',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
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
                        'CO2 = CO * 3.666',
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

                //BVT
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'CO: ',
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
                          labelText: 'g',
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
                        '*C: Carbono orgánico \n'
                        '*CO: Dióxido de carbono\n'
                        '*3.666: Factor de corrección \n',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
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
                                  const ConversionCarbonScreen()),
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
