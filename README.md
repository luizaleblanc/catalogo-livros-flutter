# Meu Catálogo de Livros

Aplicativo Flutter para consultar um catálogo de livros, pesquisar por título ou autor, filtrar por gênero, marcar favoritos e visualizar os detalhes de cada obra.

## Funcionalidades

- Pesquisa de livros por título ou autor.
- Filtro por gênero e por favoritos.
- Grade responsiva: mantém cards proporcionais no celular e aumenta automaticamente o número de colunas no desktop.
- Tela de detalhes aberta ao tocar em um livro, com capa, título, autor, gênero e descrição.
- Marcação e remoção de favoritos.

## Arquitetura

O projeto utiliza o padrão **MVVM** com `Provider`:

```text
lib/
├── models/
│   └── item_model.dart                 # Dados de cada livro
├── viewmodels/
│   ├── catalogo_viewmodel.dart         # Pesquisa, filtros e favoritos
│   └── detalhe_livro_viewmodel.dart    # Dados exibidos no detalhe
├── views/
│   ├── home_view.dart                  # Catálogo e grade de livros
│   └── detalhe_livro_view.dart         # Tela de detalhes
└── main.dart
```

A descrição pertence ao `LivroModel`. A `DetalheLivroView` a recebe pelo `DetalheLivroViewModel`, mantendo a interface separada dos dados.

## Como executar

1. Instale o [Flutter](https://docs.flutter.dev/get-started/install).
2. Instale as dependências:

   ```bash
   flutter pub get
   ```

3. Execute o projeto:

   ```bash
   flutter run
   ```

## Verificação

Para analisar o código:

```bash
flutter analyze
```

## Tecnologias

- Flutter
- Dart
- Provider
