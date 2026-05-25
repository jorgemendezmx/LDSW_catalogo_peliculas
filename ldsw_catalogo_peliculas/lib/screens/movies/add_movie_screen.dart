import 'package:flutter/material.dart';

import '../../models/movie.dart';
import '../../services/firestore_service.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController generoController =  TextEditingController();
  final TextEditingController anioController =  TextEditingController();
  final TextEditingController sinopsisController = TextEditingController();
  final TextEditingController portadaController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> saveMovie() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {

      Movie movie = Movie(
        titulo: tituloController.text.trim(),
        director: directorController.text.trim(),
        genero: generoController.text.trim(),
        anio: int.tryParse(anioController.text.trim(),) 
          ?? 0,
        sinopsis: sinopsisController.text.trim(),
        portada: portadaController.text.trim(),
      );

      await firestoreService.addMovie(movie);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Película guardada correctamente',
            ),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        return;
      }

      Navigator.pop(context);

    } catch (e) {
      setState(() {
        errorMessage = 'Error al guardar película';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar película',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration:
                  const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: directorController,
              decoration:
                  const InputDecoration(
                labelText: 'Director',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: generoController,
              decoration:
                  const InputDecoration(
                labelText: 'Género',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: anioController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: 'Año',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: portadaController,
              decoration:
                  const InputDecoration(
                labelText: 'URL de portada',
                hintText: 'Ejemplo: https://example.com/portada.jpg',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: sinopsisController,
              maxLines: 5,
              decoration:
                  const InputDecoration(
                labelText: 'Sinopsis',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Mensaje de error
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading
                  ? null
                  : saveMovie,
                child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Guardar película',
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}