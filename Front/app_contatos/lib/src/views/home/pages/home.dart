import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Listas de contatos',
            ),
            Text(
              'Contatos',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.blue[800],
        backgroundColor: Colors.blue[800],
        splashColor: Colors.blue[800],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {},
        tooltip: 'Adicionar contatos',
        child: const Icon(
          Icons.person_add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
