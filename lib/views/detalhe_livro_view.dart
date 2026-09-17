import 'package:flutter/material.dart';

import '../viewmodels/detalhe_livro_viewmodel.dart';

class DetalheLivroView extends StatelessWidget {
  const DetalheLivroView({super.key, required this.viewModel});

  final DetalheLivroViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      appBar: AppBar(
        title: const Text('Detalhes do livro'),
        backgroundColor: const Color(0xFF4A3525),
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;
          final content =
              _LivroDetalhes(viewModel: viewModel, isWide: isWide);

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: content,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LivroDetalhes extends StatelessWidget {
  const _LivroDetalhes({required this.viewModel, required this.isWide});

  final DetalheLivroViewModel viewModel;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final cover = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        viewModel.imagemPath,
        width: isWide ? 260 : double.infinity,
        height: isWide ? 390 : 320,
        fit: BoxFit.cover,
      ),
    );

    final information = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.titulo,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A3525),
              ),
        ),
        const SizedBox(height: 8),
        Text(
          viewModel.autor,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade700,
              ),
        ),
        const SizedBox(height: 16),
        Chip(label: Text(viewModel.genero)),
        const SizedBox(height: 24),
        Text(
          'Descrição',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          viewModel.descricao,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
      ],
    );

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cover,
          const SizedBox(width: 32),
          Expanded(child: information),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cover,
        const SizedBox(height: 24),
        information,
      ],
    );
  }
}
