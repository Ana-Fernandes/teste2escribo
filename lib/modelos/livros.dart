class Livro {
  final int id;
  final String titulo;
  final String autor;
  final String capaUrl;
  final String downloadUrl;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.capaUrl,
    required this.downloadUrl,
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'],
      titulo: json['title'],
      autor: json['author'],
      capaUrl: json['cover_url'],
      downloadUrl: json['download_url'],
    );
  }
}
