import 'package:flutter/material.dart';


// Importamos la lista de profesores
class Profesor {
  final String nombre;
  final String especialidad;
  final String descripcion;
  final String imagenUrl;

  Profesor({required this.nombre, required this.especialidad, required this.descripcion, required this.imagenUrl});
}

final List<Profesor> profesores = [
  Profesor(
    nombre: 'Dr. Albert Newton ',
    especialidad: 'Física Cuántica',
    descripcion: 'Experto en física cuántica con más de 20 años de experiencia en investigación y docencia.',
    imagenUrl: 'https://featteca.fandom.com/es/wiki/Kaido?file=Kaido.png',
  ),
  Profesor(
    nombre: 'Dra. María González',
    especialidad: 'Ingeniería de Software',
    descripcion: 'Lidera proyectos de desarrollo de software e inteligencia artificial.',
    imagenUrl: 'https://onepiece.fandom.com/wiki/Charlotte_Linlin?file=Charlotte+Linlin+Anime+Infobox.png',
  ),
];


class ProfesoresScreen extends StatelessWidget {
  const ProfesoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profesores'),
      ),
      body: ListView.builder(
        itemCount: profesores.length,
        itemBuilder: (context, index) {
          final profesor = profesores[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profesor.imagenUrl),
                radius: 30,
              ),
              title: Text(profesor.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(profesor.especialidad),
              onTap: () {
                // Al hacer clic, mostrar más detalles del profesor
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfesorDetailScreen(profesor: profesor),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProfesorDetailScreen extends StatelessWidget {
  final Profesor profesor;

  const ProfesorDetailScreen({super.key, required this.profesor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profesor.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(profesor.imagenUrl),
                radius: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text(profesor.nombre, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(profesor.especialidad, style: const TextStyle(fontSize: 28, fontStyle: FontStyle.italic)),
            const SizedBox(height: 10),
            Text(profesor.descripcion),
          ],
        ),
      ),
    );
  }
}
