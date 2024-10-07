import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MallaCurricularScreen extends StatefulWidget {a
  const MallaCurricularScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MallaCurricularScreenState createState() => _MallaCurricularScreenState();
}

class _MallaCurricularScreenState extends State<MallaCurricularScreen> {
  List<Offset> posicionesDeX = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPositions(); // Cargar las posiciones guardadas al iniciar
  }

  // Cargar las posiciones guardadas desde shared_preferences
  Future<void> _loadSavedPositions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedPositions = prefs.getStringList('posicionesDeX');
    if (savedPositions != null) {
      setState(() {
        posicionesDeX = savedPositions.map((pos) {
          List<String> coords = pos.split(',');
          return Offset(double.parse(coords[0]), double.parse(coords[1]));
        }).toList();
      });
    }
  }

  // Guardar las posiciones en shared_preferences
  Future<void> _savePositions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedPositions = posicionesDeX.map((pos) {
      return '${pos.dx},${pos.dy}';
    }).toList();
    await prefs.setStringList('posicionesDeX', savedPositions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Malla Curricular'),
      ),
      body: Center(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            setState(() {
              final tapPosition = details.localPosition;
              final existingIndex = posicionesDeX.indexWhere((posicion) {
                return (tapPosition - posicion).distance < 20;
              });

              // Si la X ya existe cerca, se quita. Si no, se añade.
              if (existingIndex != -1) {
                posicionesDeX.removeAt(existingIndex);
              } else {
                posicionesDeX.add(tapPosition);
              }

              _savePositions(); // Guardar las posiciones cuando se modifica
            });
          },
          child: Stack(
            children: [
              // Imagen de la malla curricular
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/Malla.png', // Ruta de la imagen de la malla
                  fit: BoxFit.contain, // Ajustar la imagen para que no ocupe toda la pantalla
                  width: MediaQuery.of(context).size.width * 0.9, // Tamaño adaptable al 90% del ancho de la pantalla
                ),
              ),
              // Dibujar X en las posiciones registradas
              ...posicionesDeX.map((posicion) {
                return Positioned(
                  left: posicion.dx - 15, // Ajustar la posición para centrar la X
                  top: posicion.dy - 15,  // Ajustar la posición para centrar la X
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 30,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menú lateral
          Container(
            width: 220,
            color: Colors.purple[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Logo del menú
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.school, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 20),
                // Opciones del menú
                _menuItem(icon: FontAwesomeIcons.gaugeHigh, label: 'Dashboard', context: context),
                _menuItem(icon: FontAwesomeIcons.book, label: 'Malla Curricular', context: context),
                _menuItem(icon: FontAwesomeIcons.graduationCap, label: 'Notas', context: context),
                _menuItem(icon: FontAwesomeIcons.folderOpen, label: 'Cursos', context: context),
                _menuItem(icon: FontAwesomeIcons.rightFromBracket, label: 'Logout', context: context),
              ],
            ),
          ),
          // Contenido Principal
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header de bienvenida
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bienvenido de vuelta, [ESTUDIANTE]!',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple[800]),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple[300],
                        child: const Icon(Icons.person, color: Colors.white, size: 40),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Sección de tarjetas principales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _dashboardCard(icon: FontAwesomeIcons.file, label: 'Ver Archivos', color: const Color.fromARGB(255, 123, 31, 162)),
                      _dashboardCard(icon: FontAwesomeIcons.upload, label: 'Subir Archivo', color: const Color.fromARGB(255, 59, 150, 64)),
                      // ignore: deprecated_member_use
                      _dashboardCard(icon: FontAwesomeIcons.infoCircle, label: 'Ver Info', color: const Color.fromARGB(255, 245, 124, 0)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Información General
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información General',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[800]),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Este es un espacio donde podemos ayudarte con apuntes de cursos de diferentes semestres. Aquí encontrarás recursos útiles y noticias relevantes para mejorar tu aprendizaje. ¡Explora y no dudes en consultar cualquier material que necesites!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Cursos en progreso
                  Text(
                    'Cursos en Progreso',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[800]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _courseCard('Programación Orientada a Objetos', FontAwesomeIcons.laptopCode),
                      _courseCard('Desarrollo de Software', FontAwesomeIcons.code),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Noticias recientes
                  Text(
                    'Noticias Recientes',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[800]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _newsItem('Noticia 1', 'Texto corto de la noticia 1'),
                  _newsItem('Noticia 2', 'Texto corto de la noticia 2'),
                  const SizedBox(height: 20),
                  // Widget interactivo
                  GestureDetector(
                    onTap: () {
                      // Aquí puedes agregar la lógica que quieras
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('¡Interacción exitosa!')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.purple[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          '¡Haz clic aquí para interactuar!',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widgets de Menú
Widget _menuItem({required IconData icon, required String label, required BuildContext context}) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
    onTap: () {
      // Lógica para navegar entre pantallas
      switch (label) {
        case 'Malla Curricular':
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MallaCurricularScreen()));
          break;
        case 'Notas':
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NotasScreen()));
          break;
        case 'Cursos':
          Navigator.push(context, MaterialPageRoute(builder: (context) => CursosScreen()));
          break;
        case 'Logout':
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirmación'),
                content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Redirige a la pantalla de login después del logout
                      Navigator.of(context).pop(); // Cierra el diálogo
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text('Logout'),
                  ),
                ],
              );
            },
          );
          break;
      }
    },
  );
}

  // Widget para las tarjetas del Dashboard
  Widget _dashboardCard({required IconData icon, required String label, required Color color}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color,
      child: Container(
        width: 100, // Reducido para que estén más juntos
        height: 100, // Reducido para que estén más juntos
        padding: const EdgeInsets.all(10), // Reducido padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white), // Reducido tamaño del ícono
            const SizedBox(height: 5), // Reducido espacio
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.center), // Reducido tamaño del texto
          ],
        ),
      ),
    );
  }

  // Widget para los cursos
  Widget _courseCard(String title, IconData icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 160,
        height: 160,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.purple[700]),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // Widget para las noticias recientes
  Widget _newsItem(String title, String subtitle) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.newspaper, color: Colors.purple),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}


// Pantalla de Malla Curricular
class NotasScreen extends StatefulWidget {
  const NotasScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final List<TextEditingController> _notaControllers = [];
  final List<TextEditingController> _porcentajeControllers = [];
  double _resultado = 0;

void _agregarNota() {
    if (_notaControllers.length < 3) {
      setState(() {
        _notaControllers.add(TextEditingController());
        _porcentajeControllers.add(TextEditingController());
      });
    }
  }

  // Método para calcular la nota final
  void _calcularNota() {
    double totalNotas = 0;
    double totalPorcentajes = 0;

    for (int i = 0; i < _notaControllers.length; i++) {
      final double nota = double.tryParse(_notaControllers[i].text) ?? 0;
      final double porcentaje = double.tryParse(_porcentajeControllers[i].text) ?? 0;

      totalNotas += nota * (porcentaje / 100);
      totalPorcentajes += porcentaje;
    }

    // Solo muestra el resultado si hay porcentajes válidos
    setState(() {
      _resultado = totalPorcentajes > 0 ? totalNotas / (totalPorcentajes / 100) : 0;
    });
    // Lógica para mostrar mensaje de felicitación o fracaso
    if (_resultado >= 3) {
      _mostrarMensaje(context, '¡Felicidades!', 'Has aprobado el curso con una nota de ${_resultado.toStringAsFixed(2)}.');
    } else {
      _mostrarMensaje(context, 'Lo siento', 'No has logrado aprobar el curso. Tu nota final es ${_resultado.toStringAsFixed(2)}.');
    }
  }

   // Método para mostrar un diálogo con un mensaje
  void _mostrarMensaje(BuildContext context, String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5BA), // Cambia el color de fondo a #fff5ba
      appBar: AppBar(
        title: const Text('Cálculo de Notas'),
      ),
      body: Center( // Centra el contenido en el medio de la pantalla
        child: Container(
          width: 320, // Ajuste para un tamaño compacto
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // Cambia la posición de la sombra
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botón para agregar una nueva nota (límite de 3)
              ElevatedButton(
                onPressed: _agregarNota,
                child: const Text('Agregar Nota y Porcentaje'),
              ),
              const SizedBox(height: 20),
              // Muestra el formulario de notas y porcentajes
              ListView.builder(
                shrinkWrap: true,
                itemCount: _notaControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Campo de texto para la nota
                        SizedBox(
                          width: 100, // Tamaño más compacto
                          child: TextField(
                            controller: _notaControllers[index],
                            decoration: const InputDecoration(
                              labelText: 'Nota',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Campo de texto para el porcentaje
                        SizedBox(
                          width: 100, // Tamaño más compacto
                          child: TextField(
                            controller: _porcentajeControllers[index],
                            decoration: const InputDecoration(
                              labelText: 'Porcentaje',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Botón para calcular la nota final
              ElevatedButton(
                onPressed: _calcularNota,
                child: const Text('Calcular Nota Final'),
              ),
              const SizedBox(height: 20),
              // Muestra el resultado final
              Text(
                'Resultado: ${_resultado.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla de Cursos
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

  // Lista de cursos
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
  ];

  // Función para mostrar el diálogo con la información del curso
  void _mostrarInformacionCurso(BuildContext context, Curso curso) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(curso.nombre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Descripción: ${curso.descripcion}'),
              const SizedBox(height: 10),
              Text('Profesor: ${curso.profesor}'),
              const SizedBox(height: 10),
              Text('Correo: ${curso.correo}'),
              const SizedBox(height: 10),
              Text('Texto Guía: ${curso.textoGuia}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
      body: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          final curso = cursos[index];
          return ListTile(
            title: Text(curso.nombre),
            onTap: () => _mostrarInformacionCurso(context, curso),
          );
        },
      ),
    );
  }
}
