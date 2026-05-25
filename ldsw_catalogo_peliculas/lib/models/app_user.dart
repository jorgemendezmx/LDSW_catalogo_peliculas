class AppUser {

  final String uid;
  final String correo;
  final String usuario;
  final String permisos;

  AppUser({
    required this.uid,
    required this.correo,
    required this.usuario,
    required this.permisos,
  });

  factory AppUser.fromFirestore(
    Map<String, dynamic> data,
    String documentId,
  ) {

    return AppUser(
      uid: documentId,
      correo: data['correo'] ?? '',
      usuario: data['usuario'] ?? '',
      permisos: data['permisos'] ?? 'lector',
    );
  }

  Map<String, dynamic> toFirestore() {

    return {
      'correo': correo,
      'usuario': usuario,
      'permisos': permisos,
    };
  }
}