# Yu-Gi-Oh! Card Search App
## Executar App
Primeiro, você precisará executar o comando flutter pub get para instalar as dependências do projeto:

flutter pub get

Para executar o aplicativo com as configurações adequadas para carregar as imagens corretamente, utilize o seguinte comando:

flutter run -d chrome --web-renderer html

Se estiver utilizando o Visual Studio Code, basta pressionar F5 para iniciar o aplicativo diretamente com essas configurações.

## Sobre o Projeto
Este é um aplicativo de busca de cartas do Yu-Gi-Oh! desenvolvido em Flutter. Ele permite que os usuários pesquisem, filtrem e visualizem detalhes das cartas do jogo.

## Funcionalidades
Pesquisa de Cartas: Pesquise por cartas utilizando um campo de pesquisa na AppBar. As cartas são exibidas em uma grade de visualização.

Filtros e Categorias: Filtre as cartas por tipo (fusion, spell, trap, monster, skill) e selecione archetypes específicos (exodia, blue-eyes, dark magician, etc.).

Detalhes das Cartas: Visualize informações detalhadas de cada carta, incluindo ATK, DEF, efeitos, e muito mais.

Navegação por Swipe: Navegue entre diferentes cartas na tela de detalhes utilizando gestos de swipe.

## Tecnologias Utilizadas
Flutter: Framework principal utilizado para o desenvolvimento do aplicativo.

Dart: Linguagem de programação utilizada.

API: [Conectado a uma API de Yu-Gi-Oh! para obter dados das cartas.](https://ygoprodeck.com/api-guide/)

## Contribuição
Contribuições são bem-vindas! Sinta-se à vontade para enviar pull requests ou abrir issues para discutir melhorias e novas funcionalidades.

## Licença
Este projeto está licenciado sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.
