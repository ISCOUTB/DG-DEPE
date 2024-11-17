import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Comentario {
  final String usuario;
  final String texto;
  final String fecha;

  Comentario({required this.usuario, required this.texto, required this.fecha});

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'texto': texto,
      'fecha': fecha,
    };
  }

  factory Comentario.fromMap(Map<String, dynamic> map) {
    return Comentario(
      usuario: map['usuario'],
      texto: map['texto'],
      fecha: map['fecha'],
    );
  }
}

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  BlogScreenState createState() => BlogScreenState();
}

class BlogScreenState extends State<BlogScreen> {
  final List<Comentario> comentarios = [];
  final TextEditingController comentarioController = TextEditingController();
  final String usuario = "Javier Serrano";

  @override
  void initState() {
    super.initState();
    _cargarComentarios();
  }

  Future<void> _cargarComentarios() async {
    final prefs = await SharedPreferences.getInstance();
    final String? comentariosJson = prefs.getString('comentarios');

    if (comentariosJson != null) {
      final List<dynamic> comentariosMap = jsonDecode(comentariosJson);
      setState(() {
        comentarios.addAll(comentariosMap.map((map) => Comentario.fromMap(map)).toList());
      });
    }
  }

  Future<void> _guardarComentarios() async {
    final prefs = await SharedPreferences.getInstance();
    final String comentariosJson = jsonEncode(comentarios.map((c) => c.toMap()).toList());
    prefs.setString('comentarios', comentariosJson);
  }

  void agregarComentario() {
    if (comentarioController.text.trim().isNotEmpty) {
      final nuevoComentario = Comentario(
        usuario: usuario,
        texto: comentarioController.text,
        fecha: DateTime.now().toString(),
      );

      setState(() {
        comentarios.add(nuevoComentario);
        comentarioController.clear();
      });

      _guardarComentarios();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El comentario no puede estar vacío'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog de recomendaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de entrada y botón
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: comentarioController,
                    decoration: const InputDecoration(
                      labelText: 'Escribe tu comentario...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: agregarComentario,
                    icon: const Icon(Icons.send),
                    label: const Text('Enviar comentario'),
                    style: ElevatedButton.styleFrom(
                      iconColor:  Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Lista de comentarios
            Expanded(
              child: comentarios.isEmpty
                  ? const Center(
                      child: Text('No hay comentarios aún. ¡Sé el primero en comentar!'),
                    )
                  : ListView.builder(
                      itemCount: comentarios.length,
                      itemBuilder: (context, index) {
                        final comentario = comentarios[index];
                        final fechaFormateada = DateFormat('d MMMM yyyy, h:mm a')
                            .format(DateTime.parse(comentario.fecha));
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          color: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                comentario.usuario[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              comentario.usuario,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(comentario.texto),
                                const SizedBox(height: 10),
                                Text(
                                  fechaFormateada,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}