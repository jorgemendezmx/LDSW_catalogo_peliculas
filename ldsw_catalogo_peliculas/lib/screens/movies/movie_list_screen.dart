import 'package:flutter/material.dart';
import '../../models/movie.dart';
import '../../services/firestore_service.dart';
import 'movie_detail_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final FirestoreService firestoreService = FirestoreService();
  List<Movie> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    final result = await firestoreService.getMovies();

    setState(() {
      movies = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de películas'),
      ),
      body: isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )

        : ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: ListTile(
                  leading: movie.portada.isNotEmpty
                  ? Image.network(
                      movie.portada,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.movie),
                  title: Text(movie.titulo),
                  subtitle: Text(
                    '${movie.director} • ${movie.anio}',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                     Navigator.push(
                      context, MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(
                          movie: movie,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
    );
  }
}