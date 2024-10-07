import 'package:flutter/material.dart';
import 'dashboard.dart'; // Asegúrate de que el archivo dashboard.dart esté en el mismo directorio

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sección izquierda (Texto de bienvenida centrado, fondo claro)
          Expanded(
            child: Container(
              color: const Color.fromRGBO(255, 245, 186, 1), // Fondo claro para la sección izquierda
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DE ESTUDIANTES PARA ESTUDIANTES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'El lugar para compartir experiencias y conocimiento',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Sección derecha (Formulario de Login)
          Expanded(
            child: Container(
              color: const Color.fromRGBO(255, 245, 186, 1), // Fondo para la pantalla derecha
              padding: const EdgeInsets.all(20.0),
              child: Center( // Centra el formulario verticalmente
                child: Container(
                  width: 500, // Aumenta el tamaño del recuadro
                  padding: const EdgeInsets.all(50.0), // Aumenta el padding interno
                  decoration: BoxDecoration(
                    color: Colors.white, // Fondo blanco para el recuadro
                    borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    border: Border.all(
                      color: Colors.grey, // Color del borde
                      width: 2, // Grosor del borde
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Sombra del recuadro
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Hace que el tamaño de la columna sea lo más pequeño posible
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 35, // Tamaño de texto adecuado para un recuadro más grande
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Detalles de tu cuenta',
                        style: TextStyle(
                          fontSize: 14, // Tamaño de texto más pequeño
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          suffixIcon: const Icon(Icons.visibility_off, color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Color.fromARGB(179, 0, 68, 255)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45), // Botón más pequeño
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          // Navega al Dashboard cuando el usuario haga login
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Dashboard()),
                          );
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¿No tienes cuenta?",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Sign up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
