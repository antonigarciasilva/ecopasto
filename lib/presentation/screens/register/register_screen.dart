import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/login/auth.dart';
import 'package:version/presentation/screens/login/login_screen.dart';
import 'package:version/presentation/screens/register/state_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
//Para las validaciones de firebase_auth
  String? errorMessage;

  String? selectValueG;

  //provider
  StateRegister? stateRegister;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateRegister = Provider.of<StateRegister>(context);
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameUsuario = TextEditingController();
  final TextEditingController _lastNameUsuario = TextEditingController();
  final TextEditingController _phoneNumberR = TextEditingController();

  final TextEditingController _emailControllerR = TextEditingController();
  final TextEditingController _passwordControllerR = TextEditingController();

  // Crear un usuario en Firebase Authentication
  Future<void> createUserWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      //Aseguramos que genero no sea nulo
      if (selectValueG == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor, seleccione su género')));
        return;
      }
      //Actualizamos datos en el provider antes de registrar
      stateRegister!.setNameUsuario(_nameUsuario.text);
      stateRegister!.setLastNameUsuario(_lastNameUsuario.text);
      stateRegister!.setPhoneNumberR(_phoneNumberR.text);
      stateRegister!.setEmailControllerR(_emailControllerR.text);
      stateRegister!.setPasswordControllerR(_passwordControllerR.text);
    }
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailControllerR.text, password: _passwordControllerR.text);

      //Navegar a la panatalla de inicio después de un registro exitoso
      // ignore: use_build_context_synchronously
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
    } catch (e) {
      //Manejar otros errores
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar los datos: $e')));
    }
  }

  //Validamos si esta registrado
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailControllerR.text,
        password: _passwordControllerR.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

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

  //Validamos el formulario y realizamos el registro
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      //Traemos los textos ingresados por el usuario
      final String nameUsuario = _nameUsuario.text;
      final String lastNameUsuario = _lastNameUsuario.text;
      final String phonenumberR = _phoneNumberR.text;
      final String passwordControllerR = _passwordControllerR.text
          .trim(); //trim elimina los espacios en blanco
      final String emailControllerR = _emailControllerR.text.trim();
      final String genero = selectValueG ?? 'No especificado';

      //Enviamos con el provider al stateRegister
      Provider.of<StateRegister>(context, listen: false)
          .setNameUsuario(nameUsuario);
      Provider.of<StateRegister>(context, listen: false)
          .setLastNameUsuario(lastNameUsuario);
      Provider.of<StateRegister>(context, listen: false)
          .setPhoneNumberR(phonenumberR);
      Provider.of<StateRegister>(context, listen: false)
          .setEmailControllerR(emailControllerR);
      Provider.of<StateRegister>(context, listen: false)
          .setPasswordControllerR(passwordControllerR);
      Provider.of<StateRegister>(context, listen: false).setGenero(genero);

      createUserWithEmailAndPassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final stateRegister = Provider.of<StateRegister>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Registrar'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //Titulo
                const Text(
                  'REGISTRO',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 82, 12, 7)),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 40,
                ),

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
                    keyboardType: TextInputType.number,
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
                      prefixIcon: const Icon(Icons.email),
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
                      onPressed: () async {
                        _submitForm();

                        //Guardamos los datos en fireStore
                        try {
                          //Obtener la ubicación antes de guardar
                          await stateRegister!.getCurrentLocation();
                          //Guardamos en firestore
                          await stateRegister!.saveToFirestore();
                          //Para verificar si el widget aún está montado
                          if (!mounted) return;
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Datos guardados satisfactoriamente!')));
                        } catch (e) {
                          if (!mounted) return;
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error al guardar los datos $e')));
                        }
                      },
                      child: const Text(
                        'Guardar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                //Mostrar mensaje de error si existe
                if (errorMessage != null) ...[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
