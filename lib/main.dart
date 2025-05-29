import 'package:flutter/material.dart';
import 'views/home_view.dart';

void main() {
  runApp(GerenciadorFilmesApp());
}

class GerenciadorFilmesApp extends StatelessWidget {
  const GerenciadorFilmesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Filmes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeView(),
    );
  }
}
