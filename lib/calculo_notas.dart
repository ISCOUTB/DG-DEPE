import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pantalla de notas
class NotasScreen extends StatefulWidget {
  const NotasScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  NotasScreenState createState() => NotasScreenState();
}

class NotasScreenState extends State<NotasScreen> {
  final List<TextEditingController> _notaControllers = [];
  final List<TextEditingController> _porcentajeControllers = [];
  double _resultado = 0;
  
  void _agregarNota() {
    if (_notaControllers.length < 3) { // Limita a 3 notas
      setState(() {
        _notaControllers.add(TextEditingController());
        _porcentajeControllers.add(TextEditingController());
      });
    }
  }

  void _calcularNota() {
    double totalNotas = 0;
    double totalPorcentajes = 0;

    for (int i = 0; i < _notaControllers.length; i++) {
      final double nota = double.tryParse(_notaControllers[i].text) ?? 0;
      final double porcentaje = double.tryParse(_porcentajeControllers[i].text) ?? 0;

      totalNotas += nota * (porcentaje / 100);
      totalPorcentajes += porcentaje;
    }

    setState(() {
      _resultado = totalPorcentajes > 0 ? totalNotas / (totalPorcentajes / 100) : 0;
    });

    if (_resultado >= 3) {
      _mostrarMensaje(context, '¡Felicidades!', 'Has aprobado el curso con una nota de ${_resultado.toStringAsFixed(2)}.');
    } else {
      _mostrarMensaje(context, 'Lo siento', 'No has logrado aprobar el curso. Tu nota final es ${_resultado.toStringAsFixed(2)}.');
    }
  }

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
                Navigator.of(context).pop();
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5BA),
      appBar: AppBar(
        title: const Text('Cálculo de Notas'),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.9,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _notaControllers.length < 3 ? _agregarNota : null, // Desactiva si ya hay 3 notas
                child: const Text('Agregar Nota y Porcentaje'),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _notaControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: _notaControllers[index],
                            decoration: const InputDecoration(
                              labelText: 'Nota',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Solo números con decimales
                              LengthLimitingTextInputFormatter(3), // Limita a 3 caracteres
                            ],
                            onChanged: (value) {
                              final double nota = double.tryParse(value) ?? 0;
                              if (nota > 5) {
                                _notaControllers[index].text = '5';
                                _notaControllers[index].selection = TextSelection.fromPosition(
                                  TextPosition(offset: _notaControllers[index].text.length),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: _porcentajeControllers[index],
                            decoration: const InputDecoration(
                              labelText: 'Porcentaje',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly, // Solo números
                              LengthLimitingTextInputFormatter(3), // Limita a 3 caracteres
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularNota,
                child: const Text('Calcular Nota Final'),
              ),
              const SizedBox(height: 20),
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
