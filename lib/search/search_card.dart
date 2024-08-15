import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../card/card_model.dart';
import '../card/detail_card/card_details_screen.dart'; 
import '../filter/filter_type.dart'; 
import 'search_body.dart'; 

class CardSearchScreen extends StatefulWidget {
  @override
  _CardSearchScreenState createState() => _CardSearchScreenState(); // Cria o estado para o widget.
}

class _CardSearchScreenState extends State<CardSearchScreen> {
  final ApiService _apiService = ApiService(); // Inicializa o serviço da API.
  final TextEditingController _controller = TextEditingController(); // Controlador para o campo de texto da barra de pesquisa.
  List<CardModel> _cards = []; // Lista de todas as cartas obtidas da API.
  List<CardModel> _filteredCards = []; // Lista de cartas filtradas para exibição.
  bool _isLoading = false; // Indica se as cartas estão sendo carregadas.
  bool _hasError = false; // Indica se ocorreu um erro ao buscar as cartas.
  int? _hoveredIndex; // Índice da carta que está sendo "hovered" (sobrevoada).
  Set<String> _selectedFilters = {}; // Filtros selecionados pelo usuário.
  String? _selectedCategory; // Categoria selecionada pelo usuário.

  @override
  void initState() {
    super.initState();
    _searchCards(''); // Realiza uma busca inicial vazia ao carregar a tela.
  }

  void _searchCards(String query) async { // Função para buscar cartas na API.
    setState(() {
      _isLoading = true; // Inicia o carregamento.
      _hasError = false; // Reseta o estado de erro.
    });

    try {
      final cards = await _apiService.fetchCards(query); // Busca cartas na API.
      setState(() {
        _cards = cards; // Atualiza a lista de cartas.
        _applyFilters(); // Aplica os filtros selecionados.
        if (_cards.isEmpty) { // Verifica se a busca retornou resultados.
          _hasError = true; // Define que houve um erro se não houver resultados.
        }
      });
    } catch (e) { // Captura erros na busca.
      print(e);
      setState(() {
        _hasError = true; // Define estado de erro se a busca falhar.
      });
    } finally {
      setState(() {
        _isLoading = false; // Finaliza o carregamento.
      });
    }
  }

  void _applyFilters() { // Aplica os filtros selecionados à lista de cartas.
    setState(() {
      if (_selectedFilters.isEmpty && _selectedCategory == null) {
        _filteredCards = List.from(_cards); // Sem filtros, mostra todas as cartas.
      } else {
        _filteredCards = _cards.where((card) { // Filtra as cartas por tipo e categoria.
          final type = card.type.toLowerCase(); // Tipo da carta.
          final archetype = card.archetype.toLowerCase(); // Arquétipo da carta.
          final matchesCategory = _selectedCategory == null || archetype.contains(_selectedCategory!.toLowerCase());
          final matchesFilter = _selectedFilters.isEmpty || _selectedFilters.any((filter) => type.contains(filter));
          return matchesCategory && matchesFilter; // Retorna cartas que combinam com os filtros.
        }).toList();
      }
    });
  }

  void _showFilterDialog() async { // Mostra o diálogo de seleção de filtros.
    final selectedFilters = await showDialog<Set<String>>(
      context: context,
      builder: (context) {
        return FilterType(selectedFilters: _selectedFilters); // Exibe o diálogo com filtros já selecionados.
      },
    );
    if (selectedFilters != null) {
      setState(() {
        _selectedFilters = selectedFilters; // Atualiza os filtros selecionados.
        _applyFilters(); // Reaplica os filtros após a seleção.
      });
    }
  }

  void _onCategoryChanged(String? category) { // Atualiza a categoria selecionada.
    setState(() {
      _selectedCategory = category;
      _applyFilters(); // Reaplica os filtros após a mudança de categoria.
    });
  }

  @override
  Widget build(BuildContext context) {
    return CardSearchScreenBody( // Passa os parâmetros necessários para o corpo da tela de busca.
      controller: _controller,
      isLoading: _isLoading,
      hasError: _hasError,
      filteredCards: _filteredCards,
      hoveredIndex: _hoveredIndex,
      selectedCategory: _selectedCategory,
      selectedFilters: _selectedFilters,
      onCardHover: (index) { // Atualiza o índice da carta que está sendo sobrevoada.
        setState(() {
          _hoveredIndex = index;
        });
      },
      onCardTap: (index) { // Navega para a tela de detalhes da carta ao clicar nela.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailsScreen(
              cards: _filteredCards,
              initialIndex: index,
            ),
          ),
        );
      },
      onSearch: (query) { // Chama a função de busca ao realizar a pesquisa.
        _searchCards(query);
      },
      onCategoryChanged: _onCategoryChanged, // Função de mudança de categoria.
      onShowFilterDialog: _showFilterDialog, // Função para exibir o diálogo de filtros.
    );
  }
}
