import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/movie.dart';

class MovieRandom extends StatefulWidget {
  const MovieRandom({super.key});

  @override
  State<MovieRandom> createState() => _MovieRandomState();
}

class _MovieRandomState extends State<MovieRandom> {
  Movie? movie;

  @override
  void initState() {
    super.initState();
    obtenerPelicula();
  }

  Future<void> obtenerPelicula() async {
    FirestoreService firestoreService = FirestoreService();
    Movie? randomMovie = await firestoreService.getRandomMovie();

    setState(() {
      movie = randomMovie;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (movie == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container (
      width: 350,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(movie!.titulo, 
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),

          SizedBox(height: 10),

          Text('Director: ${movie!.director}'),
          Text('Género: ${movie!.genero}'),
          Text('Año: ${movie!.anio}'),
          SizedBox(height: 20),

          if (movie!.portada.isNotEmpty)
            Image.network(
              movie!.portada,
              width: 200,
            ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
  
}