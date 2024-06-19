import 'package:flutter/material.dart';
import 'package:version/presentation/screens/login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectValueG;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameUsuario = TextEditingController();
  final TextEditingController _lastNameUsuario = TextEditingController();
  final TextEditingController _phoneNumberR = TextEditingController();

  final TextEditingController _emailControllerR = TextEditingController();
  final TextEditingController _passwordControllerR = TextEditingController();

  //Validación de formularios
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su correo electrónico';
    }

    //Validar el formato de email
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Por favor, ingrese un correo valido';
    }
    return null;
  }

  //Para validar que el usuario haya puesto su contraseña
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su contraseña';
    }
    return null;
  }

  //validate fullname
  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese sus datos';
    }
    return null;
  }

  //validación solo ingrese numeros
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su número de celular';
    }

    //valdiación de numeros
    final dapRegExp = RegExp(r'^9\d{8}$');
    if (!dapRegExp.hasMatch(value)) {
      return 'por favor, ingrese un número de celular valido';
    }
    return null;
  }

  //Validar el genero
  String? _validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su genero';
    }
    return null;
  }

  //Validamos el boton de registro
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REGISTRO',
          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 82, 12, 7)),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //Nombre
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameUsuario,
                    validator: _validateFullName,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Nombres',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                ),
                const SizedBox(height: 20),

                //Last name
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _lastNameUsuario,
                    validator: _validateFullName,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_4_outlined),
                        labelText: 'Apellidos',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                ),
                const SizedBox(height: 20),

                //Phone number
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _phoneNumberR,
                    validator: _validatePhoneNumber,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone_android),
                        labelText: 'Número de celular',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                ),
                const SizedBox(height: 20),

                //Gender
                const Text(
                  'Selccione su genero:',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButtonFormField<String>(
                    validator: _validateGender,
                    value: selectValueG,
                    hint: const Text('Elija su genero'),
                    onChanged: (String? value) {
                      setState(() {
                        selectValueG = value;
                      });
                    },
                    items: <String>[
                      'Masculino',
                      'Femenino',
                      'Prefiero no decirlo'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(
                                fontSize: 15,
                              )));
                    }).toList(),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //Gmail
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailControllerR,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_4),
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                //Password
                TextFormField(
                  controller: _passwordControllerR,
                  validator: _validatePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                //Botón de resgistrarse

                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 82, 12, 7)),
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
    );
  }
}
