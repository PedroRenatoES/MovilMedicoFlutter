import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerMedicosScreen extends StatefulWidget {
  @override
  _VerMedicosScreenState createState() => _VerMedicosScreenState();
}

class _VerMedicosScreenState extends State<VerMedicosScreen> {
  List<dynamic> medicos = [];
  int? especialidadId;

  Future<void> fetchMedicos() async {
    final url = especialidadId != null
        ? "http://localhost:5125/api/Medicos?especialidadId=$especialidadId"
        : "http://localhost:5125/api/Medicos";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        medicos = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Médicos")),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'ID de Especialidad'),
            onChanged: (value) {
              setState(() {
                especialidadId = int.tryParse(value);
              });
              fetchMedicos();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: medicos.length,
              itemBuilder: (context, index) {
                final medico = medicos[index];
                return ListTile(
                  title: Text(medico['nombre']),
                  subtitle: Text("Especialidad: ${medico['especialidad']}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
