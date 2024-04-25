import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:version/presentation/screens/aliso/aliso_screen.dart';

class GreenMatterScreen extends StatefulWidget {
  const GreenMatterScreen({super.key});
  @override
  MyGreenMatterScreen createState() => MyGreenMatterScreen();
}

class MyGreenMatterScreen extends State<GreenMatterScreen> {
  String? selectedValue;
  //Tengo que tener necesariamente estas dos cosas para hacer mi validadciones
  //GlobalKey<FormaState> variable = inicializo con GlobalKey<FromState(); la variable se va a usar en el form y evaluamos el estado de nuestro formulario
  //Como key: varibale

  //Con los controladores vamos a poder acceder a la información de cada texto

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeight = TextEditingController();

  //Validación de día de evaluación
  String? _validateEvaluation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa el día de evaluación';
    }
    return null;
  }

  //Validar el peso de la materia verde
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa el peso';
    }
    //Validación con regex
    final weightRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Solo acepta valores numéricos';
    }
    return null;

/*
    //Podemos agregar más if, por ejemplo
    if (value.length >= 5) {
      return "Peso muy exagerado"; 
    }

    return null;*/
  }

  //Validamos el botton guardar
  void _submitForm() {
    //usamos la llave creada del Globalkey, luego con el currentState, vemos su estado actual
    // El cual acepta valores nulos, por eso lo agregamos un "!", para decir que si o sí no será nula
    //Luego ponemos un "." y accedemos al metodo validate que da valores booleanos
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlisoScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/green_alder.jpg',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),

                  //Título
                  const SizedBox(height: 25.0),
                  const Text(
                    'Calculando la materia verde con Aliso',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Día de evaluación
                  const SizedBox(height: 25.0),

                  const Text('Día de evaluación:',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: DropdownButtonFormField<String>(
                      validator: _validateEvaluation,
                      value: selectedValue,
                      hint: const Text('Elije un valor'),
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      items: <String>['Día 30', 'Día 45', 'Día 60', 'Día 75']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  //Fecha actual
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Fecha de evaluación:   ${getFormattedDate()}',
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                    ],
                  ),

                  //Peso de la materia verde
                  const SizedBox(height: 15),

                  //Ingresa el peso de materia verde

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWeight,
                      validator: _validateWeight,
                      decoration: InputDecoration(
                        //prefixIcon: const Icon(Icons.person_4),

                        labelText: 'Ingresa el peso de materia verde',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),

                  //Guardar
                  const SizedBox(height: 15.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: _submitForm,
                        child: const Text(
                          'Guardar',
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
      ),
    );
  }

  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }
}
