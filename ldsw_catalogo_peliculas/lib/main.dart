import 'package:flutter/material.dart';

void main() {
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

// Página de inicio de la aplicación.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // Inserta el Widget de Header con imagen de fondo
            HeaderSection(),        

            const SizedBox(height: 40),

            // Texto de bienvenida
            Text('¡Encuentra aquí las mejores películas!', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text('Hello World', 
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),

            const SizedBox(height: 40),

            // Construye renglón de Películas destacadas a partir de Widget PrincipalMovie
            Row(              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PrincipalMovie(moviename: 'El silencio de los corderos'),
                PrincipalMovie(moviename: 'Dogville'),
                PrincipalMovie(moviename: 'Sentencia previa'),
              ],  
            ),

            const SizedBox(height: 40),

            // Widget de Stack para mostrar imagen de otras películas
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.black87,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Text('Drama', style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Header con imagen de fondo y botones de categoría
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
        padding: const EdgeInsets.all(48.0),
        child: Row(  // Widget Fila de íconos
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                print('Elegiste comedia');
              },
              child: Text('Comedia'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Elegiste acción');
              },
              child: Text('Acción'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Elegiste suspenso');
              },
              child: Text('Suspenso'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Elegiste buscar');
              },
              child: Icon(Icons.find_in_page, size: 25, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}

//Widget Película Destacada
class PrincipalMovie extends StatelessWidget {
  const PrincipalMovie ({super.key, required this.moviename});

  final String moviename;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
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
          Icon(Icons.movie_outlined, size: 50, color: Colors.indigo),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: Text(moviename, 
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.indigo,
              ),),
          ),
        ],
      ),
    ); 
  }
}


