import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Metodo para registro de usuario
  Future<void> registerUser({
    required String uid,
    required String correo,
    required String usuario,
  }) async {

    await _db.collection('usuarios').doc(uid).set({
      'correo': correo,
      'usuario': usuario,
      'permisos': 'lector',
    });
  }

  // Obtener todas las películas
  Future<List<Movie>> getMovies() async {

    final snapshot = await _db.collection('peliculas').get();

    return snapshot.docs.map((doc) {
      return Movie.fromFirestore(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  // Obtener películas por género
  Future<List<Movie>> getMoviesByGenre(String genre) async {

    final snapshot = await _db
        .collection('peliculas')
        .where('genero', isEqualTo: genre)
        .get();

    return snapshot.docs.map((doc) {
      return Movie.fromFirestore(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  // Obtener película aleatoria
  Future<Movie?> getRandomMovie() async {

    final snapshot = await _db.collection('peliculas').get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    snapshot.docs.shuffle();

    final doc = snapshot.docs.first;

    return Movie.fromFirestore(
      doc.data(),
      doc.id,
    );
  }

  // Agregar película
  Future<void> addMovie(Movie movie) async {

    await _db.collection('peliculas').add({
      'titulo': movie.titulo,
      'director': movie.director,
      'genero': movie.genero,
      'anio': movie.anio,
      'sinopsis': movie.sinopsis,
      'portada': movie.portada,
    });
  }
}