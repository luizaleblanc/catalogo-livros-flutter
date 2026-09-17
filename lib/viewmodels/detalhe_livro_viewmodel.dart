import '../models/item_model.dart';

class DetalheLivroViewModel {
  const DetalheLivroViewModel(this._livro);

  final LivroModel _livro;

  String get titulo => _livro.titulo;
  String get autor => _livro.autor;
  String get genero => _livro.genero;
  String get descricao => _livro.descricao;
  String get imagemPath => _livro.imagemPath;
}
