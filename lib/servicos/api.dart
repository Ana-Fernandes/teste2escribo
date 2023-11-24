import 'dart:convert';

import '../modelos/livros.dart';

Future<List<Livro>> fetchLivros() async {
  // Lista de livros fornecida
  final String jsonString = '''
    [
        {"id": 1,"title": "The Bible of Nature","author": "Oswald, Felix L.","cover_url": "https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg","download_url": "https://www.gutenberg.org/ebooks/72134.epub3.images"},
        {"id": 2,"title": "Kazan","author": "Curwood, James Oliver","cover_url": "https://www.gutenberg.org/cache/epub/72127/pg72127.cover.medium.jpg","download_url": "https://www.gutenberg.org/ebooks/72127.epub.images"},
        ...
        // Adicione todos os outros livros aqui
        ...
    ]
  ''';

  List<dynamic> jsonList = json.decode(jsonString);
  List<Livro> livros = jsonList.map((json) => Livro.fromJson(json)).toList();

  return livros;
}
