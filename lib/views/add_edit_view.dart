import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/filme.dart';
import '../controllers/filme_controller.dart';

class AddEditView extends StatefulWidget {
  final Filme? filme;

  AddEditView({this.filme});

  @override
  State<AddEditView> createState() => _AddEditViewState();
}

class _AddEditViewState extends State<AddEditView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = FilmeController();

  final _tituloController = TextEditingController();
  final _urlImagemController = TextEditingController();
  final _generoController = TextEditingController();
  final _duracaoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _anoController = TextEditingController();

  String _faixaEtariaSelecionada = 'Livre';
  double _pontuacao = 0;

  final _faixas = ['Livre', '10', '12', '14', '16', '18'];

  @override
  void initState() {
    super.initState();
    if (widget.filme != null) {
      final f = widget.filme!;
      _tituloController.text = f.titulo;
      _urlImagemController.text = f.urlImagem;
      _generoController.text = f.genero;
      _duracaoController.text = f.duracao;
      _descricaoController.text = f.descricao;
      _anoController.text = f.ano.toString();
      _faixaEtariaSelecionada = f.faixaEtaria;
      _pontuacao = f.pontuacao;
    }
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final filme = Filme(
        id: widget.filme?.id,
        titulo: _tituloController.text,
        urlImagem: _urlImagemController.text,
        genero: _generoController.text,
        faixaEtaria: _faixaEtariaSelecionada,
        duracao: _duracaoController.text,
        pontuacao: _pontuacao,
        descricao: _descricaoController.text,
        ano: int.parse(_anoController.text),
      );

      if (widget.filme == null) {
        await _controller.adicionarFilme(filme);
      } else {
        await _controller.atualizarFilme(filme);
      }

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _urlImagemController.dispose();
    _generoController.dispose();
    _duracaoController.dispose();
    _descricaoController.dispose();
    _anoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.filme != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar Filme' : 'Cadastrar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _urlImagemController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _generoController,
                decoration: InputDecoration(labelText: 'Gênero'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              DropdownButtonFormField<String>(
                value: _faixaEtariaSelecionada,
                decoration: InputDecoration(labelText: 'Faixa Etária'),
                items: _faixas
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (v) => setState(() => _faixaEtariaSelecionada = v!),
              ),
              TextFormField(
                controller: _duracaoController,
                decoration: InputDecoration(labelText: 'Duração'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _anoController,
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty || int.tryParse(v) == null
                    ? 'Informe um ano válido'
                    : null,
              ),
              SizedBox(height: 12),
              Text('Pontuação:', style: TextStyle(fontWeight: FontWeight.bold)),
              RatingBar.builder(
                initialRating: _pontuacao,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (v) => setState(() => _pontuacao = v),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvar,
                child: Text(isEdit ? 'Salvar Alterações' : 'Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
