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
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Widget Fila de íconos
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Elegiste comedia');
                  },
                  child: Text('Comedia'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    print('Elegiste acción');
                  },
                  child: Text('Acción'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    print('Elegiste suspenso');
                  },
                  child: Text('Suspenso'),
                ),
                SizedBox(width: 10),
                Icon(Icons.find_in_page, size: 30, color: Colors.blueGrey),
                SizedBox(width: 10),
              ],
            ),

            const SizedBox(height: 40),

              // Texto de bienvenida
            Text('¡Encuentra aquí las mejores películas!', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

              // Widget de contenedor para Película destacada
            Container(
              padding: const EdgeInsets.all(50.0),
              width: 300,
              color: Colors.blueGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Icon(Icons.movie, size: 50, color: Colors.white70),
                SizedBox(width: 20),
                Text('Película destacada de la semana: "El Padrino"'),
              ],), 
            ),

            const SizedBox(height: 40),

              // Widget de Stack para mostrar imagen de otras películas
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.orange,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Text('Drama', style: TextStyle(color: const Color.fromARGB(255, 117, 13, 100), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
