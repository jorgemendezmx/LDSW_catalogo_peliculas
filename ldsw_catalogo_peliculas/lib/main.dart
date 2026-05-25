import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
//import 'dart:convert';
//import 'screens/movies/movie_random.dart';
//import 'screens/movies/movie_list_screen.dart';

//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

import 'screens/auth/auth_gate.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // Widget central de la aplicación, sin estado (StatelessWidget)
  // Define la estructura básica de la aplicación, incluyendo el tema y la página de inicio.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de películas LDSW',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 68, 183, 58)),
      ),
      home: const AuthGate(),
    );
  } 
}

  

//Widget constructor de Tarjeta simple de una Película
class MovieCard extends StatelessWidget {
  const MovieCard ({super.key, required this.moviename});

  final String moviename;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Color del borde
          width: 2.0,         // Grosor del borde
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie_outlined, size: 35, color: Colors.indigo),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(moviename, 
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.normal,
                color: Colors.indigo,
              ),),
          ),
        ],
      ),
    ); 
  }
}


