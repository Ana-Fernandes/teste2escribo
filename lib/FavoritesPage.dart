import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class FavoritesPage extends StatelessWidget {
  final List<Book> favoriteBooks;

  FavoritesPage({required this.favoriteBooks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          Book book = favoriteBooks[index];
          return ListTile(
            leading: Image.network(book.coverUrl),
            title: Text(book.title),
            subtitle: Text(book.author),
            // Aqui você pode adicionar mais detalhes do livro se desejar
            // e opções para ações como abrir ou remover dos favoritos
          );
        },
      ),
    );
  }
}
