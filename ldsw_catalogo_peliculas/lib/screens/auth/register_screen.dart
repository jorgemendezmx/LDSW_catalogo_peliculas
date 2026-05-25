import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final AuthService authService = AuthService();

  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  Future<void> register() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      User? user = await authService.register(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        await firestoreService.registerUser(
          uid: user.uid,
          correo: emailController.text.trim(),
          usuario: usernameController.text.trim(),
        );
      }

      // Capta errores específicos de FirebaseAuth
    } on FirebaseAuthException catch (e) {

      setState(() {
        if (e.code == 'email-already-in-use') {
          errorMessage = 'Ese correo ya está registrado';
        
        } else if (e.code == 'weak-password') {
          errorMessage = 'La contraseña es demasiado débil';

        } else {
          errorMessage = 'Error al registrar usuario';
        }
      });

    } catch (e) {

      setState(() {
        errorMessage = 'Ocurrió un error inesperado';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const Icon(
                  Icons.person_add,
                  size: 100,
                  color: Colors.indigo,
                ),

                const SizedBox(height: 20),

                const Text('Registro de usuario',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                // Usuario
                TextField(

                  controller:
                      usernameController,

                  decoration:
                      const InputDecoration(
                    labelText: 'Usuario',
                    border:
                        OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 20),

                // email
                TextField(
                  controller:
                      emailController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Correo electrónico',
                    border:
                        OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 20),

                // Contraseña
                TextField(
                  controller:
                      passwordController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Contraseña',
                    border:
                        OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 20),

                if (errorMessage.isNotEmpty)

                  Text(
                    errorMessage,
                    style:
                        const TextStyle(
                      color: Colors.red,
                    ),
                  ),

                const SizedBox(height: 20),

                SizedBox(

                  width: double.infinity,

                  height: 50,

                  child: ElevatedButton(

                    onPressed:
                        isLoading
                            ? null
                            : register,

                    child: isLoading

                        ? const CircularProgressIndicator()

                        : const Text(
                            'Registrarse',
                          ),
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