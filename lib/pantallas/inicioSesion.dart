import 'package:flutter/material.dart';
import 'package:flutter_medico_api_web_1/services/auth_service.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  
  void _login() async {
    final result = await AuthService().login(_email, _password);
    if (result != null) {
      final pacienteId = result['pacienteId'];
      // Guarda el pacienteId en almacenamiento seguro
      Navigator.pushReplacementNamed(context, '/main', arguments: pacienteId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login fallido')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Iniciar Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                onChanged: (value) => _password = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
