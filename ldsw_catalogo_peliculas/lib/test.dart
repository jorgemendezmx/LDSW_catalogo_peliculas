import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
//import 'dart:convert';

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
      home: const MyHomePage(title: 'Catálogo de Películas'),
    );
  } 
}

// Página de inicio de la aplicación; cambió a StatefulWidget para manejar el estado de los datos obtenidos de la API.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}

// Estado de la página de inicio, donde se manejan los datos 
// obtenidos de la API y se construye la interfaz de usuario.
class _MyHomePageState extends State<MyHomePage> {
  String titulo = '';
  String director = '';
  String genero = '';
  String sinopsis = '';
  String portada = '';
  int anio = 0;

  bool isLoading = true;
  String errorMessage = '';

  Future<void> obtenerPelicula() async {

    try {
      final doc = await FirebaseFirestore.instance
          .collection('peliculas')
          .doc('pelicula001')
          .get();

      if (doc.exists) {

        final data = doc.data();
        setState(() {
          titulo = data?['titulo'] ?? '';
          director = data?['director'] ?? '';
          genero = data?['genero'] ?? '';
          sinopsis = data?['sinopsis'] ?? '';
          portada = data?['portada'] ?? '';
          anio = data?['anio'] ?? 0;
          isLoading = false;
        });

      } else {
        setState(() {
          errorMessage = 'La película no existe';
          isLoading = false;
        });
      }

    } catch (e) {
      setState(() {
        errorMessage = 'Error al consultar Firestore';
        isLoading = false;
      });

      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerPelicula();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Inserta el Widget de Header con imagen de fondo
            HeaderSection(),        

            const SizedBox(height: 40),

            // Texto de bienvenida
            Text('¡Encuentra aquí las mejores películas!', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            // Construye renglón de Películas partir de Widget MovieCard
            Row(              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MovieCard(moviename: titulo),
                MovieCard(moviename: titulo),
                MovieCard(moviename: titulo),
              ],  
            ),

            const SizedBox(height: 40),

            // Construye Widget con película obtenida de Firebase, mostrando indicador de carga y mensaje de error si es necesario
            if (isLoading)
            CircularProgressIndicator(),

            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),

            if (!isLoading && errorMessage.isEmpty)
              Column(
                children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text('Director: $director'),

                Text('Género: $genero'),

                Text('Año: $anio'),

                SizedBox(height: 20),

                if (portada.isNotEmpty)
                  Image.network(
                    portada,
                    width: 200,
                  ),

                SizedBox(height: 20),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    sinopsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Géneros'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Lógica para cambiar de pantalla
        },
      ),
    );
  }
}

// Widget Header con imagen de fondo y botones de acciones CRUD
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/septimoarte.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(  // Widget Fila de íconos
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            ElevatedButton(
              onPressed: () {
                print('Mostrar lista de películas');
              },
              child: Text('Lista',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('Agregar nueva película');
              },
              child: Text('Agregar',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('Buscar película');
              },
              child: Icon(Icons.find_in_page, size: 20, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
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

