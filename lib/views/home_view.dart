import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/catalogo_viewmodel.dart';
import '../viewmodels/detalhe_livro_viewmodel.dart';
import '../models/item_model.dart';
import 'detalhe_livro_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      appBar: AppBar(
        title: const Text(
          'Meu Catálogo - Livros',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4A3525),
        elevation: 4,
      ),
      body: Consumer<CatalogoViewModel>(
        builder: (context, viewModel, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              final horizontalPadding = isDesktop ? 24.0 : 12.0;

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 12.0,
                    ),
                    color: const Color(0xFFE8E2D5),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (value) => viewModel.pesquisar(value),
                              decoration: InputDecoration(
                                hintText: 'Pesquisar livro ou autor...',
                                prefixIcon: const Icon(Icons.search,
                                    color: Color(0xFF4A3525)),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 0.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    initialValue: viewModel.generoSelecionado,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    items: viewModel.generosDisponiveis
                                        .map((genero) {
                                      return DropdownMenuItem(
                                        value: genero,
                                        child: Text(genero,
                                            style:
                                                const TextStyle(fontSize: 13)),
                                      );
                                    }).toList(),
                                    onChanged: (novoGenero) {
                                      if (novoGenero != null) {
                                        viewModel.filtrarPorGenero(novoGenero);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                FilterChip(
                                  label: const Text('Favoritos'),
                                  selected: viewModel.apenasFavoritos,
                                  selectedColor: const Color(0xFFC8B39B),
                                  onSelected: (selected) {
                                    viewModel.alternarApenasFavoritos(selected);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, gridConstraints) {
                        if (gridConstraints.maxWidth <= 0) {
                          return const SizedBox.shrink();
                        }

                        if (viewModel.livrosFiltrados.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhum livro encontrado.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          );
                        }

                        final gridWidth = gridConstraints.maxWidth > 1440
                            ? 1440.0
                            : gridConstraints.maxWidth;

                        return Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: gridWidth,
                            child: GridView.builder(
                              padding: EdgeInsets.all(isDesktop ? 24 : 10),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 220,
                                childAspectRatio: 0.58,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: viewModel.livrosFiltrados.length,
                              itemBuilder: (context, index) {
                                final livro = viewModel.livrosFiltrados[index];
                                return _buildCardLivro(
                                    context, livro, viewModel);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCardLivro(
      BuildContext context, LivroModel livro, CatalogoViewModel viewModel) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DetalheLivroView(
                viewModel: DetalheLivroViewModel(livro),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    livro.imagemPath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.8),
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        livro.eFavorito
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: livro.eFavorito ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        viewModel.alternarFavorito(livro.id);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  livro.titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  livro.autor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A3525).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    livro.genero,
                    style:
                        const TextStyle(fontSize: 10, color: Color(0xFF4A3525)),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
