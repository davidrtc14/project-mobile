import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controllers/filme_controller.dart';
import '../models/filme.dart';
import 'add_edit_view.dart';
import 'detalhe_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = FilmeController();
  List<Filme> _filmes = [];

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  Future<void> _carregarFilmes() async {
    final filmes = await _controller.listarFilmes();
    setState(() => _filmes = filmes);
  }

  void _excluir(int id) async {
    await _controller.excluirFilme(id);
    _carregarFilmes();
  }

  void _mostrarMenu(Filme filme, Offset position) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
      items: [
        PopupMenuItem(value: 'detalhes', child: Text('Exibir Dados')),
        PopupMenuItem(value: 'editar', child: Text('Alterar')),
      ],
    );

    if (result == 'detalhes') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => DetalheView(filme: filme)));
    } else if (result == 'editar') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditView(filme: filme)))
        .then((_) => _carregarFilmes());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Filmes'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'Gerenciador de Filmes',
              children: [
                  Text('Grupo:'),
                  Text('- David Ramalho'),
                  Text('- Gabriel Alves'),
                  Text('- Mayara Ferreira'),
                  Text('- Miguel Dantas'),
                ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filmes.length,
        itemBuilder: (context, index) {
          final filme = _filmes[index];
          return Dismissible(
            key: Key(filme.id.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _excluir(filme.id!),
            child: GestureDetector(
              onTapDown: (details) => _mostrarMenu(filme, details.globalPosition),
              child: ListTile(
                leading: Image.network(filme.urlImagem, width: 50, height: 70, fit: BoxFit.cover),
                title: Text(filme.titulo),
                subtitle: RatingBarIndicator(
                  rating: filme.pontuacao,
                  itemCount: 5,
                  itemBuilder: (_, __) => Icon(Icons.star, color: Colors.amber),
                  itemSize: 20,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditView()))
            .then((_) => _carregarFilmes());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
