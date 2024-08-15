import 'package:flutter/material.dart';
import 'package:yu_gi_oh__api/constants.dart';

class FilterType extends StatefulWidget {
  final Set<String> selectedFilters; // Filtros que já foram selecionados pelo usuário.

  FilterType({required this.selectedFilters});

  @override
  _FilterTypeState createState() => _FilterTypeState();
}

class _FilterTypeState extends State<FilterType> {
  late Set<String> _filters; // Estado local para armazenar filtros selecionados.
  final List<String> _allFilters = [ // Lista de todos os filtros possíveis.
    'fusion', 
    'spell', 
    'trap', 
    'monster', 
    'skill'
  ];

  @override
  void initState() {
    super.initState();
    _filters = Set.from(widget.selectedFilters); // Inicializa com os filtros já selecionados.
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog( // Exibe um diálogo para seleção de filtros.
      backgroundColor: AppColors.BgColor, // Cor de fundo do diálogo.
      title: Text(
        'Select Filters',
        style: TextStyle(color: AppColors.TextColor1), // Cor do texto "Select Filters" baseada no tema.
      ),
      content: SingleChildScrollView(
        child: Column(
          children: _allFilters.map((filter) { // Mapeia os filtros disponíveis para checkboxes.
            return CheckboxListTile(
              title: Text(
                filter,
                style: TextStyle(color: AppColors.TextColor1), // Estilo do texto do filtro, baseado no tema.
              ),
              value: _filters.contains(filter), // Verifica se o filtro já foi selecionado.
              onChanged: (isChecked) { // Ação ao marcar/desmarcar um filtro.
                setState(() { 
                  if (isChecked ?? false) { 
                    _filters.add(filter); // Adiciona o filtro ao conjunto se marcado.
                  } else {
                    _filters.remove(filter); // Remove o filtro se desmarcado.
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton( // Botão "Cancel".
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.TextColor1), // Cor do texto "Cancel", baseada no tema.
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o diálogo sem aplicar mudanças.
          },
        ),
        TextButton( // Botão "Apply".
          child: Text(
            'Apply',
            style: TextStyle(color: AppColors.TextColor1), // Cor do texto "Apply", baseada no tema.
          ),
          onPressed: () {
            Navigator.of(context).pop(_filters); // Retorna os filtros selecionados ao fechar o diálogo.
          },
        ),
      ],
    );
  }
}
