import 'package:flutter/material.dart';

import '../../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(movie.portada.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Image.network(
                  movie.portada,
                  fit: BoxFit.cover,
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.titulo,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 0),

                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          movie.director,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                      ),
                      const SizedBox(width: 10),
                      Text(movie.genero),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        movie.anio.toString(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Sinopsis',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie.sinopsis,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para editar película
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(245, 10, 100, 20), // Color de fondo
                          foregroundColor: Colors.white, // Color del texto y los iconos
                          elevation: 5, // Elevación y sombra del botón
                        ),
                        child: const Text('Editar'),
                      ),
                      
                      const SizedBox(width: 30),

                      ElevatedButton(
                        onPressed: () {
                          // Lógica para eliminar película
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(245, 245, 29, 29), // Color de fondo
                          foregroundColor: Colors.white, // Color del texto y los iconos
                          elevation: 5, // Elevación y sombra del botón
                        ),
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}