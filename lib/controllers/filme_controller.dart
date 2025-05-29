import '../models/filme.dart';
import '../db/database_helper.dart';

class FilmeController {
  final _dbHelper = DatabaseHelper();

  Future<List<Filme>> listarFilmes() async {
    return await _dbHelper.getFilmes();
  }

  Future<void> adicionarFilme(Filme filme) async {
    await _dbHelper.insertFilme(filme);
  }

  Future<void> atualizarFilme(Filme filme) async {
    await _dbHelper.updateFilme(filme);
  }

  Future<void> excluirFilme(int id) async {
    await _dbHelper.deleteFilme(id);
  }
}
