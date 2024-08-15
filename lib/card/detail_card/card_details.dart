import 'package:flutter/material.dart';
import 'package:yu_gi_oh__api/constants.dart';
import '../card_model.dart';
import 'detail_card.dart';

// Widget para exibir detalhes de uma carta
class CardDetails extends StatelessWidget {
  final CardModel card; // Modelo de dados da carta

  CardDetails({required this.card});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Espaçamento ao redor do conteúdo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  card.imageUrl, // URL da imagem da carta
                  width: 300,
                  height: 440,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) {
                      return child; // Exibe a imagem quando carregada
                    } else {
                      return Center(
                        child: Image.asset(
                          'images/cards_bg.jpg', // Imagem de fundo enquanto carrega
                          width: 300,
                          height: 440,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error); // Ícone de erro se a imagem falhar
                  },
                ),
              ),
              SizedBox(height: 8),
              Text(
                card.name, // Nome da carta
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.TextColor1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                card.type, // Tipo da carta
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.TextColor3,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width * 0.9, // Largura do container
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10, // Espaçamento horizontal entre os detalhes
                  runSpacing: 10, // Espaçamento vertical entre as linhas de detalhes
                  children: _buildDetailCards(card), // Lista de detalhes da carta
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Card Text', // Título para a descrição da carta
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.TextColor1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8, // Limita a largura da descrição
                ),
                child: Text(
                  card.desc, // Descrição da carta
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.TextColor1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Constrói a lista de widgets detalhados com base nas propriedades da carta
  List<Widget> _buildDetailCards(CardModel card) {
    List<Widget> detailCards = [];
    
    // Adiciona widgets para cada atributo da carta, se presente
    if (card.atk != 0) {
      detailCards.add(DetailCard(title: 'ATK', value: card.atk.toString(), icon: 'images/sword.png'));
    }
    if (card.def != 0) {
      detailCards.add(DetailCard(title: 'DEF', value: card.def.toString(), icon: Icons.shield));
    }
    if (card.level != 0) {
      detailCards.add(DetailCard(title: 'Level', value: card.level.toString(), icon: 'images/level.png'));
    }
    if (card.race.toLowerCase() != 'unknown') {
      detailCards.add(DetailCard(title: 'Typing', value: card.race, icon: Icons.assistant_rounded));
    }
    if (card.attribute.toLowerCase() != 'unknown') {
      detailCards.add(DetailCard(title: 'Attribute', value: card.attribute, icon: 'images/${card.attribute}.png'));
    }
    if (card.archetype.toLowerCase() != 'unknown') {
      detailCards.add(DetailCard(title: 'Archetype', value: card.archetype, icon: Icons.assignment_rounded));
    }
    
    return detailCards;
  }
}
