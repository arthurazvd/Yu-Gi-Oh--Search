import 'package:flutter/material.dart';
import 'package:yu_gi_oh__api/constants.dart';
import '../card_model.dart';
import 'dart:ui';
import 'card_details.dart';

// Tela para exibir detalhes das cartas em uma visualização de página
class CardDetailsScreen extends StatefulWidget {
  final List<CardModel> cards; // Lista de cartas a serem exibidas
  final int initialIndex; // Índice inicial da carta a ser exibida

  CardDetailsScreen({required this.cards, required this.initialIndex});

  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  late PageController _pageController; // Controlador para navegação entre páginas
  ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0); // Notificador para página atual

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex); // Inicializa o controlador da página com o índice inicial
    _currentPageNotifier.value = widget.initialIndex; // Define a página inicial no notificador
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Estende o corpo da tela atrás da AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0, // Sem sombra na AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navega para a tela anterior
          },
        ),
        iconTheme: IconThemeData(
          color: AppColors.TextColor1, // Cor dos ícones na AppBar
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _currentPageNotifier, // Atualiza o conteúdo com base na página atual
        builder: (context, currentPage, child) {
          return Stack(
            fit: StackFit.expand, // Expande o stack para preencher o espaço disponível
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.cards[currentPage].imageUrlCropped), // Imagem de fundo da carta
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Desfoque de fundo
                  child: Container(
                    color: AppColors.BgColor.withOpacity(0.7), // Cor de fundo com opacidade
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight + 50), // Padding para o conteúdo abaixo da AppBar
                child: PageView.builder(
                  controller: _pageController, // Controlador para navegação entre páginas
                  itemCount: widget.cards.length, // Número total de páginas
                  onPageChanged: (index) {
                    _currentPageNotifier.value = index; // Atualiza o notificador quando a página muda
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.topCenter, // Alinha o conteúdo ao topo
                      child: CardDetails(card: widget.cards[index]), // Exibe os detalhes da carta
                    );
                  },
                ),
              ),
              if (MediaQuery.of(context).size.width > 600) // Exibe botões de navegação somente em telas grandes
                _buildArrowButton(Icons.keyboard_arrow_left, Alignment.centerLeft, _pageController.previousPage, context),
              if (MediaQuery.of(context).size.width > 600)
                _buildArrowButton(Icons.keyboard_arrow_right, Alignment.centerRight, _pageController.nextPage, context),
            ],
          );
        },
      ),
    );
  }

  // Método auxiliar para criar botões de navegação
  Widget _buildArrowButton(IconData icon, Alignment alignment, Function onPressed, BuildContext context) {
    return Positioned(
      left: alignment == Alignment.centerLeft ? 16 : null, // Posiciona o botão à esquerda
      right: alignment == Alignment.centerRight ? 16 : null, // Posiciona o botão à direita
      top: MediaQuery.of(context).size.height / 2 - 24, // Alinha o botão verticalmente ao meio da tela
      child: Visibility(
        visible: alignment == Alignment.centerLeft
            ? _currentPageNotifier.value > 0 // Verifica se há páginas anteriores
            : _currentPageNotifier.value < widget.cards.length - 1, // Verifica se há páginas seguintes
        child: IconButton(
          icon: Icon(icon, size: 48, color: AppColors.TextColor1), // Ícone do botão
          onPressed: () => onPressed(duration: Duration(milliseconds: 300), curve: Curves.easeInOut), // Ação do botão com animação
        ),
      ),
    );
  }
}
