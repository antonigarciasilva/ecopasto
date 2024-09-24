import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'package:version/presentation/screens/register/register_screen.dart';
import 'package:version/presentation/screens/tutorial/tutorial_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage;

  //Función para iniciar sesión con  firebase_auth

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      //Si el inicio de sesión es exitoso, navega a la pantalla de tutorial

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const TutorialScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showAlertDialog('Usuario no registrado',
            'El correo electrónico ingresado no está registrado');
      } else if (e.code == 'wrong-password') {
        _showAlertDialog('Contraseña incorrecta',
            'La contraseña que has ingresado es incorrecta.');
      } else {
        setState(() {
          errorMessage = e.message;
        });
      }
    }
  }

  //Mostrar mensaje de error
  void _showAlertDialog(String title, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }

//Para validar el email del usuario
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su correo electrónico.';
    }
    //Validar el formato de email
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Por favor, ingrese un correo valido.';
    }
    return null;
  }

//Para validar que el usuario hayta puesto su contraseña
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su contraseña.';
    }
    return null;
  }

  //Validamos el boton de inicio de sesión

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      signInWithEmailAndPassword();
    }
  }

  //Función para restablecer contraseña
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showAlertDialog('Correo enviado',
          'Se ha enviado un enlace para restablecer tu contraseña al correo proporcionado.');
    } on FirebaseAuthException catch (e) {
      _showAlertDialog(
          'Error', e.message ?? 'Ha ocurrido un error inesperado.');
    }
  }

  //Dialogo para ingresar el correo electrónico
  void _showPasswordResetDialog() {
    final TextEditingController resetEmailController = TextEditingController();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Restablecer contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            content: TextField(
              controller: resetEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 12),
                hintText: 'Ingresa el correo electrónico',
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    final email = resetEmailController.text.trim();
                    if (email.isNotEmpty) {
                      resetPassword(email);
                      Navigator.of(context).pop();
                    } else {
                      _showAlertDialog(
                          'Error', 'Por favor, ingresa un correo válido');
                    }
                  },
                  child: const Text('Enviar')),
              TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('Cancelar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //Creamos una variable para hacer responsive la pg
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/img/amas_color.png',
                  height: size.height * 0.21,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),

                //Usuario
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_4),
                      labelText: 'Usuario',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),

                //Contraseña
                TextFormField(
                  controller: _passwordController,
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

                //Olvidaste tu contraseña
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextButton(
                    onPressed: _showPasswordResetDialog,
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ),

                //Iniciar sesion
                SizedBox(
                  height: size.height * 0.05,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 82, 12, 7)),
                    ),
                    onPressed: _submitForm,
                    child: const Text(
                      'INICIAR SESIÓN',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                //Registrate
                SizedBox(
                  height: size.height * 0.02,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                      child: const Text('REGISTRATE',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 82, 12, 7)))),
                ),

                //Seguir como invitado
                SizedBox(
                  height: size.height * 0.02,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TutorialScreen()));
                      },
                      child: const Text('Continuar como invitado',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 5, 67, 7)))),
                ),
                if (errorMessage != null) ...[
                  SizedBox(
                    height: size.height * 0.03,
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
