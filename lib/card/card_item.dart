import 'package:flutter/material.dart';
import 'card_model.dart';
import '../constants.dart';

class CardItem extends StatelessWidget {
  final CardModel card; // Dados da carta a ser exibida
  final bool isHovered; // Indica se o item está com o mouse sobre ele
  final Function() onEnter; // Função a ser chamada quando o mouse entra na área do widget
  final Function() onExit; // Função a ser chamada quando o mouse sai da área do widget
  final Function() onTap; // Função a ser chamada quando o widget é clicado

  CardItem({
    required this.card,
    required this.isHovered,
    required this.onEnter,
    required this.onExit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onEnter(), // Chama a função onEnter ao passar o mouse sobre o widget
      onExit: (_) => onExit(), // Chama a função onExit ao tirar o mouse do widget
      child: InkWell(
        onTap: onTap, // Chama a função onTap ao clicar no widget
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Duração da animação do container
          transform: isHovered
              ? (Matrix4.identity()
                ..translate(-20.0, -28.0) // Desloca o widget quando está com o mouse sobre ele
                ..scale(1.1)) // Aumenta a escala do widget quando está com o mouse sobre ele
              : Matrix4.identity(), // Sem transformação quando não está com o mouse sobre ele
          curve: Curves.easeInOut, // Curva da animação para um efeito suave
          decoration: BoxDecoration(
            color: isHovered ? AppColors.Color2.withOpacity(0.5) : Colors.transparent, // Muda a cor de fundo quando está com o mouse sobre o widget
            borderRadius: BorderRadius.circular(10), // Define os cantos arredondados do container
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza os itens verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens horizontalmente
            children: [
              Container(
                width: double.infinity, // Largura do container é 100% do pai
                height: 344, // Altura fixa do container
                child: card.imageUrlSmall.isNotEmpty
                    ? Image.network(
                        card.imageUrlSmall,
                        width: 240, // Largura da imagem
                        height: 344, // Altura da imagem
                        fit: BoxFit.contain, // Ajusta a imagem para caber no container
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) {
                            return child; // Exibe a imagem quando está carregada
                          } else {
                            return Center(
                              child: Image.asset(
                                'images/cards_bg.jpg', // Imagem de fundo enquanto a imagem da carta está carregando
                                width: 240,
                                height: 344,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, color: AppColors.TextColor1); // Exibe um ícone de erro se a imagem falhar ao carregar
                        },
                      )
                    : Icon(Icons.image_not_supported, color: AppColors.TextColor1), // Exibe um ícone se a URL da imagem estiver vazia
              ),
              SizedBox(height: 8), // Espaçamento entre a imagem e o nome da carta
              Text(
                card.name,
                textAlign: TextAlign.center, // Centraliza o texto horizontalmente
                style: TextStyle(fontSize: 18, color: AppColors.TextColor1),
                overflow: TextOverflow.ellipsis, // Abrevia o texto se ele for muito longo
                maxLines: 1, // Limita o texto a uma linha
              ),
              SizedBox(height: 3), // Espaçamento entre o nome e o tipo da carta
              Text(
                card.type,
                textAlign: TextAlign.center, // Centraliza o texto horizontalmente
                style: TextStyle(fontSize: 16, color: AppColors.TextColor3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
