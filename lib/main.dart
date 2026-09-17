import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/catalogo_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CatalogoViewModel(),
      child: MaterialApp(
        title: 'Meu Catálogo de Livros',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
