import 'package:flutter/material.dart';

//pantalla de cursos
class Curso {
  final String nombre;
  final String descripcion;
  final String profesor;
  final String correo;
  final String textoGuia;

  Curso({
    required this.nombre,
    required this.descripcion,
    required this.profesor,
    required this.correo,
    required this.textoGuia,
  });
}

class CursosScreen extends StatelessWidget {
  CursosScreen({super.key});

  final List<Curso> cursos = [
    Curso(
      nombre: 'Programación Orientada a Objetos',
      descripcion: 'Este curso se enfoca en el paradigma de programación orientada a objetos.',
      profesor: 'Juan Pérez',
      correo: 'juan.perez@universidad.edu',
      textoGuia: 'Apuntes de POO',
    ),
    Curso(
      nombre: 'Desarrollo de Software',
      descripcion: 'El curso aborda las metodologías y técnicas en el desarrollo de software.',
      profesor: 'María López',
      correo: 'maria.lopez@universidad.edu',
      textoGuia: 'Manual de Desarrollo Ágil',
    ),
    Curso(
      nombre: 'Ecuaciones Diferenciales',
      descripcion: 'Este curso aborda temas avanzados de cálculo, necesario haber cursado los anteriores.',
      profesor: 'Jose Perez Santander Priciliano',
      correo: 'jos.priciliano@universidad.edu',
      textoGuia: 'Calculo de Thomas (14a edición)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          final curso = cursos[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  curso.nombre,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  curso.descripcion,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blue),
                    const SizedBox(width: 5),
                    Text(
                      'Profesor: ${curso.profesor}',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.blue),
                    const SizedBox(width: 5),
                    Text(
                      'Correo: ${curso.correo}',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.book, color: Colors.blue),
                    const SizedBox(width: 5),
                    Text(
                      'Texto Guía: ${curso.textoGuia}',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}