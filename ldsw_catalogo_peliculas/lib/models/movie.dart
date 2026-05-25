class Movie {

  //final String id;
  final String titulo;
  final String director;
  final String genero;
  final String sinopsis;
  final String portada;
  final int anio;

  Movie({
    //required this.id,
    required this.titulo,
    required this.director,
    required this.genero,
    required this.sinopsis,
    required this.portada,
    required this.anio,
  });

  factory Movie.fromFirestore(Map<String, dynamic> data, String documentId) {

    return Movie(
      //id: documentId,
      titulo: data['titulo'] ?? '',
      director: data['director'] ?? '',
      genero: data['genero'] ?? '',
      sinopsis: data['sinopsis'] ?? '',
      portada: data['portada'] ?? '',
      anio: data['anio'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {

    return {
      'titulo': titulo,
      'director': director,
      'genero': genero,
      'sinopsis': sinopsis,
      'portada': portada,
      'anio': anio,
    };
  }
}