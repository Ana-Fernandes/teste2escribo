import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

import 'FavoritesPage.dart'; // Importando a biblioteca Dio para download de arquivos

void main() {
  runApp(MyApp());
}

class Book {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estante de Livros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: BookshelfPage(),
    );
  }
}

class BookshelfPage extends StatefulWidget {
  @override
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  late List<Book> books = [];
  List<Book> favorites = [];
  late String filePath = ''; // Variável para armazenar o caminho do livro baixado

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response =
      await http.get(Uri.parse('https://escribo.com/books.json'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          books = data.map((item) {
            return Book(
              id: item['id'],
              title: item['title'],
              author: item['author'],
              coverUrl: item['cover_url'],
              downloadUrl: item['download_url'],
            );
          }).toList();
        });
      } else {
        throw Exception('Falha ao carregar livros');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  // Função para iniciar o download do livro
  startDownload() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = appDocDir!.path + '/sample.epub';
    File file = File(path);
    Dio dio = Dio();

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        "https://vocsyinfotech.in/envato/cc/flutter_ebook/uploads/22566_The-Racketeer---John-Grisham.epub",
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            // Pode ser usado para exibir o progresso do download
          });
        },
      ).whenComplete(() {
        setState(() {
          filePath = path; // Atualiza o caminho do arquivo após o download
        });
      });
    } else {
      setState(() {
        filePath = path; // Define o caminho do arquivo se já existir
      });
    }
  }

  Future<void> _openBook(String filePath) async {
    // Lógica para abrir o livro
  }

  void _toggleFavorite(Book book) {
    setState(() {
      if (favorites.contains(book)) {
        favorites.remove(book);
      } else {
        favorites.add(book);
      }
    });
  }

  bool _isBookFavorite(Book book) {
    return favorites.contains(book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estante de Livros'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(favoriteBooks: favorites),
                ),
              );
            },
          ),
        ],
      ),
      body: books.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          Book book = books[index];
          return GestureDetector(
            onTap: () {
              _openBook(filePath); // Abrir o livro ao tocar no item
            },
            child: Stack(
              children: [
                // Exibindo a capa do livro
                Image.network(
                  book.coverUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isBookFavorite(book)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                          _isBookFavorite(book) ? Colors.red : null,
                        ),
                        onPressed: () {
                          _toggleFavorite(book);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          startDownload(); // Iniciar o download ao tocar no botão
                        },
                        child: Text('Download'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
