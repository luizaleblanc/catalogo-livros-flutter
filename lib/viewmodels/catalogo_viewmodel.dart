import 'package:flutter/material.dart';
import '../models/item_model.dart';

class CatalogoViewModel extends ChangeNotifier {
  final List<LivroModel> _livros = [
    LivroModel(
      id: '1',
      titulo: 'Dom Casmurro',
      autor: 'Machado de Assis',
      genero: 'Romance',
      descricao: 'Uma análise da dúvida e ciúme na sociedade brasileira.',
      imagemPath: 'assets/imagens/livro1.jpg',
    ),
    LivroModel(
      id: '2',
      titulo: 'O Hobbit',
      autor: 'J.R.R. Tolkien',
      genero: 'Fantasia',
      descricao: 'A jornada inesperada de Bilbo Bolseiro na Terra-média.',
      imagemPath: 'assets/imagens/livro2.jpg',
    ),
    LivroModel(
      id: '3',
      titulo: '1984',
      autor: 'George Orwell',
      genero: 'Ficção Científica',
      descricao:
          'Um clássico distópico sobre o controle governamental totalitário.',
      imagemPath: 'assets/imagens/livro3.jpg',
    ),
    LivroModel(
      id: '4',
      titulo: 'Orgulho e Preconceito',
      autor: 'Jane Austen',
      genero: 'Romance',
      descricao: 'O relacionamento conturbado entre Elizabeth Bennet e Darcy.',
      imagemPath: 'assets/imagens/livro4.jpg',
    ),
    LivroModel(
      id: '5',
      titulo: 'Drácula',
      autor: 'Bram Stoker',
      genero: 'Terror',
      descricao: 'A clássica história epistolar sobre o Conde Drácula.',
      imagemPath: 'assets/imagens/livro5.jpg',
    ),
    LivroModel(
      id: '6',
      titulo: 'Frankenstein',
      autor: 'Mary Shelley',
      genero: 'Ficção Científica',
      descricao: 'A busca obsessiva de Victor Frankenstein e a Criatura.',
      imagemPath: 'assets/imagens/livro6.jpg',
    ),
    (LivroModel(
      id: '7',
      titulo: 'Vermelho, Branco e Sangue Azul',
      autor: 'Casey McQuiston',
      genero: 'LGBTQIA+',
      descricao:
          'Um romance contemporâneo que mistura política e amor entre o príncipe britânico e o filho da presidente dos EUA.',
      imagemPath: 'assets/imagens/livro7.jpg',
    )),
    LivroModel(
      id: '8',
      titulo: 'Da Terra à Lua',
      autor: 'Júlio Verne',
      genero: 'Ficção Científica',
      descricao:
          'Uma aventura científica que narra a tentativa de enviar um projétil à Lua.',
      imagemPath: 'assets/imagens/livro8.jpg',
    ),
  ];

  String _termoPesquisa = '';
  String _generoSelecionado = 'Todos';
  bool _apenasFavoritos = false;

  String get generoSelecionado => _generoSelecionado;
  bool get apenasFavoritos => _apenasFavoritos;

  List<String> get generosDisponiveis => [
        'Todos',
        'Romance',
        'Fantasia',
        'Ficção Científica',
        'Terror',
        'LGBTQIA+'
      ];

  List<LivroModel> get livrosFiltrados {
    return _livros.where((livro) {
      final atendePesquisa =
          livro.titulo.toLowerCase().contains(_termoPesquisa.toLowerCase()) ||
              livro.autor.toLowerCase().contains(_termoPesquisa.toLowerCase());

      final atendeGenero =
          _generoSelecionado == 'Todos' || livro.genero == _generoSelecionado;

      final atendeFavoritos = !_apenasFavoritos || livro.eFavorito;

      return atendePesquisa && atendeGenero && atendeFavoritos;
    }).toList();
  }

  void alternarFavorito(String id) {
    final index = _livros.indexWhere((item) => item.id == id);
    if (index != -1) {
      _livros[index].eFavorito = !_livros[index].eFavorito;
      notifyListeners();
    }
  }

  void filtrarPorGenero(String genero) {
    _generoSelecionado = genero;
    notifyListeners();
  }

  void pesquisar(String texto) {
    _termoPesquisa = texto;
    notifyListeners();
  }

  void alternarApenasFavoritos(bool valor) {
    _apenasFavoritos = valor;
    notifyListeners();
  }
}
