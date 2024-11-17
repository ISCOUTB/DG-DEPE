import 'package:flutter/material.dart';
import 'package:flutter_application_1/profesores_screen.dart';
import 'package:flutter_application_1/blog_screen.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/cursos.dart';
import 'package:flutter_application_1/calculo_notas.dart';
import 'package:flutter_application_1/malla_curricular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  bool _isSidebarExpanded = false;
  int cursosAprobados = 0;

  @override
  void initState() {
    super.initState();
    _cargarCursosAprobados();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cargarCursosAprobados();
  }

  Future<void> _cargarCursosAprobados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cursosAprobados = prefs.getInt('cursosAprobados') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    String noticiaTitulo = 'Noticia!!';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFFA3D9A5), // Verde menta
        actions: [
          IconButton(
            icon: Icon(_isSidebarExpanded ? Icons.close : Icons.menu),
            onPressed: () {
              setState(() {
                _isSidebarExpanded = !_isSidebarExpanded;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSidebarExpanded)
            Container(
              width: screenWidth,
              color: const Color(0xFFB5EAD7), // Verde pastel más claro
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.school, size: 40, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Dashboard',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  _menuItem(icon: FontAwesomeIcons.gaugeHigh, label: 'Dashboard', context: context),
                  _menuItem(icon: FontAwesomeIcons.book, label: 'Malla Curricular', context: context),
                  _menuItem(icon: FontAwesomeIcons.graduationCap, label: 'Notas', context: context),
                  _menuItem(icon: FontAwesomeIcons.folderOpen, label: 'Cursos', context: context),
                  _menuItem(icon: FontAwesomeIcons.addressCard, label: 'Profesores', context: context),
                  _menuItem(icon: FontAwesomeIcons.share, label: 'Blog de recomendaciones', context: context),
                  _menuItem(icon: FontAwesomeIcons.rightFromBracket, label: 'Logout', context: context),
                ],
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFEEBB99), // Coral pastel
                        child: Text(
                          'J',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Javier Serrano',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF856D8E), // Lavanda oscuro
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Edad: 21 años',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text(
                            'Semestre: 6°',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Cursos aprobados: ' '$cursosAprobados',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5BA), // Fondo amarillo pastel
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información General',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF856D8E),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Este es un espacio donde podemos ayudarte con apuntes de cursos de diferentes semestres. ¡Explora y consulta cualquier material que necesites!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Cursos en Progreso',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF856D8E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _courseCard('Programación Orientada a Objetos', FontAwesomeIcons.laptopCode, context),
                      _courseCard('Desarrollo de Software', FontAwesomeIcons.code, context),
                      _courseCard('Ecuaciones Diferenciales', FontAwesomeIcons.buffer, context),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Noticias Recientes',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF856D8E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _newsItem(noticiaTitulo, 'Recuerda que hasta el 19 de oct tienes plazo para retirar'),
                  _newsItem(noticiaTitulo, 'Se acerca el fin de corte, ¿estás preparado?'),
                  _newsItem(noticiaTitulo, 'Disponible para reclamar tu insignia digital. ¡No te lo pierdas!'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _menuItem({required IconData icon, required String label, required BuildContext context}) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
    onTap: () async {
      // Navegación y actualización del contador en caso de la "Malla Curricular"
      if (label == 'Malla Curricular') {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MallaCurricularScreen()),
        );
        _cargarCursosAprobados(); // Actualiza cursos aprobados después de regresar
      } else {
        // Lógica de navegación para las otras pantallas
        switch (label) {
          case 'Notas':
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NotasScreen()));
            break;
          case 'Cursos':
            Navigator.push(context, MaterialPageRoute(builder: (context) => CursosScreen()));
            break;
          case 'Profesores':
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfesoresScreen()));
            break;
          case 'Blog de recomendaciones':
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BlogScreen()));
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
      }
    },
  );
}

  Widget _courseCard(String courseName, IconData icon, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CursosScreen(),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD), // Azul pastel
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF64B5F6), size: 20),
          const SizedBox(width: 10),
          Text(
            courseName,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _newsItem(String title, String subtitle) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.newspaper, color: Color(0xFFEEBB99)),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
