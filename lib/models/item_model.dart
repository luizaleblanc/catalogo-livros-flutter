class LivroModel {
  final String id;
  final String titulo;
  final String autor;
  final String genero;
  final String descricao;
  final String imagemPath;
  bool eFavorito;

  LivroModel({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.genero,
    required this.descricao,
    required this.imagemPath,
    this.eFavorito = false,
  });
}
