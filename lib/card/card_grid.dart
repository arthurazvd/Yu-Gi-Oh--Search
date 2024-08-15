import 'package:flutter/material.dart';
import 'card_model.dart';
import 'card_item.dart';

class CardGrid extends StatelessWidget {
  final List<CardModel> cards; // Lista de cartas a serem exibidas
  final int? hoveredIndex; // Índice da carta atualmente sobre a qual o mouse está
  final Function(int) onCardHover; // Função a ser chamada quando o mouse entra ou sai de uma carta
  final Function(int) onCardTap; // Função a ser chamada quando uma carta é clicada

  CardGrid({
    required this.cards,
    required this.hoveredIndex,
    required this.onCardHover,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400, // Largura máxima dos itens da grade
        childAspectRatio: 240 / 344, // Relação de aspecto dos itens
        crossAxisSpacing: 16, // Espaçamento entre os itens horizontalmente
        mainAxisSpacing: 16, // Espaçamento entre os itens verticalmente
      ),
      itemCount: cards.length, // Número de itens na grade
      itemBuilder: (context, index) {
        final card = cards[index]; // Obtém a carta para o índice atual
        final isHovered = hoveredIndex == index; // Verifica se o item está sendo sobrevoado

        return CardItem(
          card: card, // Dados da carta a serem exibidos
          isHovered: isHovered, // Define se a carta está sendo sobrevoada
          onEnter: () => onCardHover(index), // Função chamada ao entrar com o mouse sobre a carta
          onExit: () => onCardHover(-1), // Função chamada ao sair com o mouse da carta
          onTap: () => onCardTap(index), // Função chamada ao clicar na carta
        );
      },
    );
  }
}
