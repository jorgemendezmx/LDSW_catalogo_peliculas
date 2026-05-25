import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService authService = AuthService();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> login() async {

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      await authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

    } catch (e) {
      setState(() {
        errorMessage = 'Correo o contraseña incorrectos';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage("images/septimoarte.jpg"),
                  width: 200,
                ),

                const SizedBox(height: 10),

                const Text('Catálogo de Películas LDSW',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                const Text('Inicia sesión para disfrutar del catálogo',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Campo email
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 20),

                // Campo contraseña
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 20),

                // Maneo de errores
                if (errorMessage.isNotEmpty)

                  Text(errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),

                const SizedBox(height: 20),

                // Botón de login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(onPressed: isLoading
                      ? null
                      : login,
                    child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Iniciar sesión'),
                  ),
                ),

                const SizedBox(height: 20),

                // Botón de registro
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const RegisterScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    'Crear cuenta',
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}