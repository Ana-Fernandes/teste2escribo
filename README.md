# teste2

Um aplicativo simples para visualizar e baixar livros em formato EPUB.

## Descrição

Este aplicativo foi desenvolvido em Flutter e tem como objetivo mostrar uma estante de livros, permitindo visualizar as capas dos livros e baixá-los para leitura offline. Os livros são carregados a partir de um endpoint fornecido por `https://escribo.com/books.json`.

## Funcionalidades

- Visualização da estante de livros
- Download de livros em formato EPUB
- Adicionar e remover livros aos favoritos

## Tecnologias Utilizadas

- Flutter
- Dart
- HTTP (pacote `http`)
- Path Provider (pacote `path_provider`)
- Dio (pacote `dio`)

## Estrutura do Projeto

O projeto consiste em:

- `main.dart`: Arquivo principal com a configuração do aplicativo e a definição das telas.
- `BookshelfPage`: Página principal que exibe a estante de livros.
- `Book`: Classe modelo para representar um livro.
- `FavoritesPage`: Página para exibir os livros marcados como favoritos.
- Integração com `vocsy_epub_viewer` para visualizar os livros em formato EPUB.

## Como Executar

Para executar este projeto localmente:

1. Clone este repositório.
2. Abra o projeto no seu editor de código.
3. Execute o aplicativo em um emulador ou dispositivo físico utilizando o comando `flutter run`.

Certifique-se de ter o ambiente do Flutter configurado corretamente para executar o projeto.

## Screenshots

_Adicione aqui imagens ou gifs do aplicativo em execução, se desejar._

## Contribuição

Contribuições são bem-vindas! Se você quiser melhorar este projeto, fique à vontade para abrir uma issue ou pull request.

## Licença

Este projeto está licenciado sob a [Licença MIT](https://opensource.org/licenses/MIT).
