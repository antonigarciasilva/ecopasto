import 'package:flutter/material.dart';
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TutorialScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'assets/img/EcoPasto.png',
                  height: 250,
                ),
                const SizedBox(height: 20.0),

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
                const SizedBox(
                  height: 20.0,
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
                    onPressed: () {},
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ),

                //Iniciar sesion
                const SizedBox(height: 35.0),
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
                const SizedBox(height: 1.0),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
