import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

List<Map<String, dynamic>> generarMallaCurricular() {
  // Datos base organizados por nivel y cursos
  final nivelesYCursos = {
    'Nivel I': [
      'Taller de comprensión lectora',
      'Cálculo Diferencial',
      'Matemáticas Básicas',
      'Química General',
      'Desarrollo Universitario',
      'Seminario Ing sistemas',
      'Fundamentos de programación',
    ],
    'Nivel II': [
      'Física Mecánica',
      'Cálculo Integral',
      'Lengua Extranjera I',
      'Álgebra lineal',
      'Programación',
    ],
    'Nivel III': [
      'Física electricidad y magnetismo',
      'Cálculo vectorial',
      'Lengua Extranjera II',
      'Taller de escritura academica',
      'Programación orientada a objetos',
    ],
    'Nivel IV': [
      'Física calor y ondas',
      'Ecuaciones diferenciales',
      'Lengua Extranjera III',
      'Estructura de datos',
      'Matematica discreta',
    ],
    'Nivel V': [
      'Constitucion politica',
      'Estadistica y probabilidad',
      'Lengua Extranjera IV',
      'Base de datos',
      'Desarrollo de software',
      'Algoritmo y complejidad',
    ],
    'Nivel VI': [
      'Creatividad y emprendimiento',
      'Estadistica inferencial',
      'Lengua Extranjera V',
      'Arquitectura de software',
      'Procesamiento numerico',
      'Comunicaciones y redes',
    ],
    'Nivel VII': [
      'Ciudadania global',
      'Formulacion y evaluacion de proyectos',
      'Ingenieria de software',
      'Arquitectura del computador',
      'Sistemas y modelos',
      'Electiva complementaria I',
    ],
    'Nivel VIII': [
      'Electiva de humanidades I',
      'Inteligencia artificial',
      'Infraestructura para TI',
      'Sistemas operativos',
      'Proyecto de ingenieria I',
      'Electiva complementaria II',
    ],
    'Nivel IX': [
      'Electiva de humanidades II',
      'Electiva empresarial',
      'Computacion en paralelo',
      'TOP ESP de ciencias computacionales',
      'Proyecto de ingenieria II',
      'Electiva complementaria III',
    ],
    'Nivel X': [
      'Etica',
      'Electiva complementaria IV',
      'Practica profesional',
    ],
  };

  // Transformar datos base en estructura con información adicional
  return nivelesYCursos.entries.map((entry) {
    return {
      'semestre': entry.key,
      'cursos': entry.value.map((curso) {
        return {'nombre': curso, 'aprobado': false};
      }).toList(),
    };
  }).toList();
}

class MallaCurricularScreen extends StatefulWidget {
  const MallaCurricularScreen({super.key});

  @override
  MallaCurricularScreenState createState() => MallaCurricularScreenState();
}

class MallaCurricularScreenState extends State<MallaCurricularScreen> {
  List<Map<String, dynamic>> mallaCurricular = generarMallaCurricular();

  @override
  void initState() {
    super.initState();
    _cargarEstado();
  }

  Future<void> _cargarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    final String? estadoJson = prefs.getString('estadoMallaCurricular');
    if (estadoJson != null) {
      setState(() {
        mallaCurricular = List<Map<String, dynamic>>.from(jsonDecode(estadoJson));
      });
    }
  }

  Future<void> _guardarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    final String estadoJson = jsonEncode(mallaCurricular);
    prefs.setString('estadoMallaCurricular', estadoJson);
    await _actualizarCursosAprobados();
  }

  int calcularCursosAprobados() {
    return mallaCurricular.fold(
      0,
      (count, semestre) =>
          count + (semestre['cursos'] as List).where((curso) => curso['aprobado']).length,
    );
  }

  Future<void> _actualizarCursosAprobados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('cursosAprobados', calcularCursosAprobados());
  }

  void actualizarEstadoCurso(int semestreIndex, int cursoIndex, bool aprobado) {
    setState(() {
      mallaCurricular[semestreIndex]['cursos'][cursoIndex]['aprobado'] = aprobado;
    });
    _guardarEstado();
  }

  void toggleAprobado(int semestreIndex, int cursoIndex) {
    final curso = mallaCurricular[semestreIndex]['cursos'][cursoIndex];
    actualizarEstadoCurso(semestreIndex, cursoIndex, !curso['aprobado']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Malla Curricular'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: mallaCurricular.length,
        itemBuilder: (context, semestreIndex) {
          final nivel = mallaCurricular[semestreIndex];
          return ExpansionTile(
            title: Text(nivel['semestre']),
            children: List.generate(nivel['cursos'].length, (cursoIndex) {
              final curso = nivel['cursos'][cursoIndex];
              return CursoItem(
                nombre: curso['nombre'],
                aprobado: curso['aprobado'],
                onToggle: () => toggleAprobado(semestreIndex, cursoIndex),
              );
            }),
          );
        },
      ),
    );
  }
}

class CursoItem extends StatelessWidget {
  final String nombre;
  final bool aprobado;
  final VoidCallback onToggle;

  const CursoItem({
    required this.nombre,
    required this.aprobado,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        nombre,
        style: TextStyle(
          decoration: aprobado ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Icon(
        aprobado ? Icons.check_box : Icons.check_box_outline_blank,
        color: aprobado ? Colors.green : null,
      ),
      onTap: onToggle,
    );
  }
}
