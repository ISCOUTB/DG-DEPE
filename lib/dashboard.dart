import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Row(
        children: [
          // Menú lateral
          Container(
            width: 220,
            color: Colors.purple[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Logo del menú
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.school, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 20),
                // Opciones del menú
                _menuItem(icon: FontAwesomeIcons.tachometerAlt, label: 'Dashboard', context: context),
                _menuItem(icon: FontAwesomeIcons.book, label: 'Malla Curricular', context: context),
                _menuItem(icon: FontAwesomeIcons.graduationCap, label: 'Notas', context: context),
                _menuItem(icon: FontAwesomeIcons.folderOpen, label: 'Cursos', context: context),
                _menuItem(icon: FontAwesomeIcons.signOutAlt, label: 'Logout', context: context),
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
                        'Bienvenido de vuelta, [USER]!',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple[800]),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple[300],
                        child: Icon(Icons.person, color: Colors.white, size: 40),
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
                      _dashboardCard(icon: FontAwesomeIcons.infoCircle, label: 'Ver Info', color: const Color.fromARGB(255, 245, 124, 0)),
                    ],
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
                  const SizedBox(height: 10),
                  _newsItem('Noticia 1', 'Texto corto de la noticia 1'),
                  _newsItem('Noticia 2', 'Texto corto de la noticia 2'),
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
      title: Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: () {
        // Lógica para navegar entre pantallas
        switch (label) {
        case 'Malla Curricular':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MallaCurricularScreen()));
          break;
        case 'Notas':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NotasScreen()));
          break;
        case 'Cursos':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CursosScreen()));
          break;
          case 'Logout':
           showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmación'),
                content: Text('¿Estás seguro de que deseas cerrar sesión?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                    },
                     child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Lógica de logout aquí
                       Navigator.of(context).pop(); // Cierra el diálogo
                    },
                     child: Text('Logout'),
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
        width: 120,
        height: 120,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(label, style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
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
            Text(title, style: TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // Widget para las noticias recientes
  Widget _newsItem(String title, String subtitle) {
    return ListTile(
      leading: Icon(FontAwesomeIcons.newspaper, color: Colors.purple),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

// Pantalla de Malla Curricular
class MallaCurricularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Malla Curricular'),
      ),
      body: Center(
        child: Text('Aquí va la malla curricular',
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// Pantalla de Notas
class NotasScreen extends StatefulWidget {
  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _porcentajeController = TextEditingController();
  double _resultado = 0;

  void _calcularNota() {
    final double nota = double.tryParse(_notaController.text) ?? 0;
    final double porcentaje = double.tryParse(_porcentajeController.text) ?? 0;
    setState(() {
      _resultado = (nota * porcentaje) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de Notas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _notaController,
              decoration: InputDecoration(
                  labelText: 'Nota', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _porcentajeController,
              decoration: InputDecoration(
                  labelText: 'Porcentaje', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularNota,
              child: Text('Calcular Nota'),
            ),
            const SizedBox(height: 20),
            Text('Resultado: $_resultado', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

// Pantalla de Cursos
class CursosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
      ),
      body: Center(
        child: Text('Aquí van los cursos disponibles',
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
