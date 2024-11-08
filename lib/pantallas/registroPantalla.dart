import 'package:flutter/material.dart';
import 'package:flutter_medico_api_web_1/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = await AuthService().register(_formData);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registro exitoso')));
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro de Paciente")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => _formData['Nombre'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apellido'),
                onSaved: (value) => _formData['Apellido'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha de Nacimiento (YYYY-MM-DD)'),
                onSaved: (value) => _formData['FechaNacimiento'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Género'),
                onSaved: (value) => _formData['Genero'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Teléfono'),
                onSaved: (value) => _formData['Telefono'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dirección'),
                onSaved: (value) => _formData['Direccion'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['Email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                onSaved: (value) => _formData['password'] = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
