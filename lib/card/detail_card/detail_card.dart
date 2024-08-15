import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yu_gi_oh__api/constants.dart';

// Widget para exibir um cartão de detalhe com título, valor e ícone
class DetailCard extends StatelessWidget {
  final String title; // Título do detalhe
  final String value; // Valor do detalhe
  final dynamic icon; // Ícone associado ao detalhe (pode ser String ou IconData)

  DetailCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Largura fixa do cartão
      padding: EdgeInsets.all(8), // Espaçamento interno
      decoration: BoxDecoration(
        color: AppColors.Color2.withOpacity(0.7), // Cor de fundo com opacidade
        borderRadius: BorderRadius.circular(8), // Bordas arredondadas
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Alinha o conteúdo verticalmente ao centro
        crossAxisAlignment: CrossAxisAlignment.center, // Alinha o conteúdo horizontalmente ao centro
        children: [
          Text(
            title, // Exibe o título
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.TextColor1, // Cor do texto
            ),
            textAlign: TextAlign.center, // Alinha o texto ao centro
          ),
          SizedBox(height: 8), // Espaçamento vertical entre o título e o valor
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Alinha o conteúdo horizontalmente ao centro
            children: [
              _buildIcon(), // Constrói o ícone baseado no tipo
              SizedBox(width: 10), // Espaçamento horizontal entre o ícone e o valor
              Text(
                value, // Exibe o valor
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.TextColor1, // Cor do texto
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Constrói o ícone dependendo do tipo fornecido
  Widget _buildIcon() {
    if (icon is String) {
      if (icon.endsWith('.svg')) {
        // Se a string é um SVG, usa SvgPicture para exibir o ícone
        return SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
          color: AppColors.TextColor1, // Cor do ícone SVG
        );
      } else {
        // Caso contrário, usa Image.asset para exibir o ícone de imagem
        return Image.asset(
          icon,
          width: 20,
          height: 20,
        );
      }
    } else if (icon is IconData) {
      // Se o ícone é um IconData, usa Icon para exibir o ícone
      return Icon(
        icon,
        size: 20,
        color: AppColors.TextColor1, // Cor do ícone
      );
    } else {
      return SizedBox.shrink(); // Retorna um widget vazio se o ícone não for válido
    }
  }
}
