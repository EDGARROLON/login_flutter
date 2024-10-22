import 'package:flutter/material.dart';

// Clase Usuario
class Usuario {
  final String nombre;
  final String login;
  final String password;
  final String email;

  Usuario({required this.nombre, required this.login, required this.password, required this.email});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicación de Inicio de Sesión',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<Usuario> usuarios = [
    Usuario(nombre: "Edgar Donaldo Rolon", login: "edgar", password: "1234", email: "edgar@example.com"),
    Usuario(nombre: "Alfredo Olivas", login: "alfredoO", password: "1234", email: "alfredo@example.com"),
  ];

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _intentos = 0;

  void _iniciarSesion() {
    String login = _loginController.text;
    String password = _passwordController.text;

    if (login.isEmpty || password.isEmpty) {
      // Mostrar mensaje de error si los campos están vacíos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos.')),
      );
      return;
    }

    final usuarioEncontrado = usuarios.firstWhere(
      (usuario) => usuario.login == login && usuario.password == password,
      orElse: () => Usuario(nombre: "", login: "", password: "", email: ""),
    );

    if (usuarioEncontrado.login.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetalleUsuarioScreen(usuario: usuarioEncontrado),
        ),
      );
    } else {
      setState(() {
        _intentos++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login o contraseña incorrectos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: Center( // Centra el contenido en el medio de la pantalla
        child: Container(
          width: 300, // Ancho del contenedor
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white, // Color de fondo
            borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
            boxShadow: [
              BoxShadow(
                color: Colors.black26, // Sombra
                blurRadius: 10.0, // Difuminado
                spreadRadius: 2.0, // Extensión
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Minimiza el tamaño del Column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Inicio de sesión', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              TextField(
                controller: _loginController,
                decoration: InputDecoration(
                  labelText: 'Ingrese su login',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Ingrese su contraseña',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _iniciarSesion,
                child: Text('Entrar', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 16),
              Text('Intentos: $_intentos', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class DetalleUsuarioScreen extends StatelessWidget {
  final Usuario usuario;

  DetalleUsuarioScreen({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenid@ a la APP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Usuario: ${usuario.login}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Nombre completo: ${usuario.nombre}', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
