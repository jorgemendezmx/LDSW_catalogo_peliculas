import 'package:flutter/material.dart';
import 'movie_random.dart';
import 'movie_list_screen.dart';
import '../../services/auth_service.dart';
import 'add_movie_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _showAccountMenu() {
    final user = AuthService().currentUser;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),

                    SizedBox(width: 10),

                    Text(
                      user?.email ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              ListTile(
                leading: Icon(Icons.admin_panel_settings),
                title: Text('Administrar'),
                onTap: () {
                  Navigator.pop(context);

                  print('Abrir panel administración');
                },
              ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Salir'),
                onTap: () async {
                  Navigator.pop(context);
                  await AuthService().logout();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Inserta el Widget de Header con imagen de fondo
            HeaderSection(),        

            const SizedBox(height: 40),

            // Inserta el Widget de home con película aleatoria
            MovieRandom(),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Géneros'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          //BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mi cuenta')
        ],
        currentIndex: 0,
        onTap: (index) {
          // Lógica para cambiar de pantalla
          if(index == 2){
            _showAccountMenu();
          }
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MovieListScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.list, size: 20),
                  SizedBox(width: 5),
                  Text('Lista',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                print('Agregar nueva película');
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (_) => const AddMovieScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.add, size: 20),
                  SizedBox(width: 5),
                  Text('Agregar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),

            //ElevatedButton(
            //  onPressed: () {
            //    print('Buscar película');
            //  },
            //  child: Icon(Icons.find_in_page, size: 20, color: Colors.blueGrey),
            //),
          ],
        ),
      ),
    );
  }
}