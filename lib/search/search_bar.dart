import 'package:flutter/material.dart';
import '../constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller; // Controla o texto digitado no campo de texto.
  final Function(String) onSearch; // Função que é chamada quando o usuário realiza uma pesquisa.

  SearchBar({required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95, // Define a largura da barra de pesquisa como 95% da largura da tela.
      decoration: BoxDecoration(
        color: AppColors.Color2, // Define a cor de fundo da barra de pesquisa.
        borderRadius: BorderRadius.circular(30), // Define bordas arredondadas para a barra de pesquisa.
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search for cards...',
          hintStyle: TextStyle(color: AppColors.TextColor2), // Estilo do texto de dica.
          border: InputBorder.none, // Remove as bordas padrão do campo de texto.
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Espaçamento interno no campo de texto.
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: AppColors.TextColor1), // Ícone de pesquisa no campo de texto.
            onPressed: () {
              onSearch(controller.text); // Chama a função de pesquisa com o texto inserido.
            },
          ),
        ),
        style: TextStyle(color: AppColors.TextColor1), // Estilo do texto digitado pelo usuário.
        onSubmitted: onSearch, // Chama a função de pesquisa ao submeter o texto.
      ),
    );
  }
}
