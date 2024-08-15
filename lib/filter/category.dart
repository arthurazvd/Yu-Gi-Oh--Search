import 'package:flutter/material.dart';
import 'package:yu_gi_oh__api/constants.dart';

class CategoryDropdown extends StatelessWidget {
  final String? selectedCategory; // Categoria atualmente selecionada.
  final void Function(String?) onCategoryChanged; // Função chamada ao mudar a categoria.

  CategoryDropdown({
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final List<String> _categories = [ // Lista de categorias disponíveis no dropdown.
    'Exodia',
    'Blue-eyes',
    'Red-eyes',
    'Dark Magician',
    'Elemental Hero',
    'Egyptian God',
    'Toon',
    'Dragon',
    'Warrior',
    'Kuriboh',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCategory, // Categoria selecionada atualmente.
      hint: Text(
        'Category',
        style: TextStyle(color: AppColors.TextColor1), // Cor do texto "Category" baseada no tema.
      ),
      dropdownColor: AppColors.BgColor, // Cor de fundo do dropdown, baseada no tema.
      icon: Icon(Icons.arrow_drop_down, color: AppColors.TextColor1), // Ícone de seta, cor baseada no tema.
      items: [
        DropdownMenuItem<String>(
          value: null, // Opção para "nenhuma categoria" selecionada.
          child: Text('Category', style: TextStyle(color: AppColors.TextColor1)),
        ),
        ..._categories.map((String category) { // Mapeia as categorias para itens do menu.
          return DropdownMenuItem<String>(
            value: category, // Valor da categoria no dropdown.
            child: Text(category, style: TextStyle(color: AppColors.TextColor1)), // Exibe o nome da categoria com a cor do tema.
          );
        }).toList(),
      ],
      onChanged: (String? category) { // Chama a função ao selecionar uma nova categoria.
        onCategoryChanged(category);
      },
    );
  }
}
