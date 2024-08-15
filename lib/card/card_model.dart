class CardModel {
  final int id; // ID da carta.
  final String name; // Nome da carta.
  final String type; // Tipo da carta.
  final String desc; // Descrição da carta.
  final String imageUrl; // URL da imagem principal da carta.
  final String imageUrlSmall; // URL da imagem em tamanho pequeno.
  final String imageUrlCropped; // URL da imagem cortada.
  final int atk; // Pontos de ataque da carta.
  final int def; // Pontos de defesa da carta.
  final int level; // Nível da carta.
  final String race; // Raça da carta.
  final String attribute; // Atributo da carta.
  final String archetype; // Arquétipo da carta.

  CardModel({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    required this.imageUrl,
    required this.imageUrlSmall,
    required this.imageUrlCropped,
    required this.atk,
    required this.def,
    required this.level,
    required this.race,
    required this.attribute,
    required this.archetype,
  });

  // Método para criar uma instância de CardModel a partir de um JSON.
  factory CardModel.fromJson(Map<String, dynamic> json) {
    final cardImages = json['card_images'][0]; // Obtém as URLs de imagem da primeira entrada de 'card_images'.
    return CardModel(
      id: json['id'] ?? '', // ID da carta, se não existir, usa uma string vazia.
      name: json['name'], // Nome da carta.
      type: json['type'], // Tipo da carta.
      desc: json['desc'], // Descrição da carta.
      imageUrl: cardImages['image_url'], // URL da imagem principal da carta.
      imageUrlSmall: cardImages['image_url_small'], // URL da imagem em tamanho pequeno.
      imageUrlCropped: cardImages['image_url_cropped'], // URL da imagem cortada.
      atk: json['atk'] ?? 0, // Pontos de ataque, padrão é 0 se não existir.
      def: json['def'] ?? 0, // Pontos de defesa, padrão é 0 se não existir.
      level: json['level'] ?? 0, // Nível da carta, padrão é 0 se não existir.
      race: json['race'] ?? 'Unknown', // Raça da carta, padrão é 'Unknown' se não existir.
      attribute: json['attribute'] ?? 'Unknown', // Atributo da carta, padrão é 'Unknown' se não existir.
      archetype: json['archetype'] ?? 'Unknown', // Arquétipo da carta, padrão é 'Unknown' se não existir.
    );
  }
}
