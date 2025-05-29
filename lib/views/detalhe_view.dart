import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/filme.dart';

class DetalheView extends StatelessWidget {
  final Filme filme;

  const DetalheView({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Filme')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Image.network(
                filme.urlImagem,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(filme.titulo,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Divider(),
            _itemInfo('Gênero', filme.genero),
            _itemInfo('Faixa Etária', filme.faixaEtaria),
            _itemInfo('Duração', filme.duracao),
            _itemInfo('Ano', filme.ano.toString()),
            SizedBox(height: 8),
            Text('Pontuação:', style: TextStyle(fontWeight: FontWeight.bold)),
            RatingBarIndicator(
              rating: filme.pontuacao,
              itemBuilder: (_, __) => Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 30,
            ),
            SizedBox(height: 16),
            Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(filme.descricao, textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }

  Widget _itemInfo(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}
