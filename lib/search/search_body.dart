import 'package:flutter/material.dart';
import 'package:yu_gi_oh__api/constants.dart';
import 'search_bar.dart' as custom_search_bar;
import '../card/card_grid.dart';
import '../card/card_model.dart';
import '../filter/category.dart';
import 'dart:ui';
import '../about_screen.dart';

class CardSearchScreenBody extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final bool hasError;
  final List<CardModel> filteredCards;
  final int? hoveredIndex;
  final String? selectedCategory;
  final Set<String> selectedFilters;
  final Function(int) onCardHover;
  final Function(int) onCardTap;
  final Function(String) onSearch;
  final Function(String?) onCategoryChanged;
  final VoidCallback onShowFilterDialog;

  CardSearchScreenBody({
    required this.controller,
    required this.isLoading,
    required this.hasError,
    required this.filteredCards,
    required this.hoveredIndex,
    required this.selectedCategory,
    required this.selectedFilters,
    required this.onCardHover,
    required this.onCardTap,
    required this.onSearch,
    required this.onCategoryChanged,
    required this.onShowFilterDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: AppColors.BgColor.withOpacity(0.9),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: LayoutBuilder(
              builder: (context, constraints) {
                return Text(
                  constraints.maxWidth < 400 ? 'YGO! CS' : 'Yu-Gi-Oh! Card Search',
                );
              },
            ),
            actions: [
              CategoryDropdown(
                selectedCategory: selectedCategory,
                onCategoryChanged: onCategoryChanged,
              ),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: onShowFilterDialog,
              ),
              IconButton(
                icon: Icon(Icons.info_outline), // Ícone de "Sobre".
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()), // Navega para a tela "Sobre".
                  );
                },
              ),
            ],
            iconTheme: IconThemeData(
              color: AppColors.TextColor1,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                custom_search_bar.SearchBar(
                  controller: controller,
                  onSearch: onSearch,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : hasError
                          ? Center(
                              child: Text(
                                'No results.',
                                style: TextStyle(color: AppColors.TextColor1, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : CardGrid(
                              cards: filteredCards,
                              hoveredIndex: hoveredIndex,
                              onCardHover: onCardHover,
                              onCardTap: onCardTap,
                            ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
