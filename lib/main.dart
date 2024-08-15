import 'package:flutter/material.dart'; 
import 'search/search_card.dart'; 
import 'constants.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      title: 'Yu-Gi-Oh! Card Search', 
      theme: ThemeData( 
        scaffoldBackgroundColor: AppColors.BgColor, // Define a cor de fundo para todas as telas da aplicação.
        textTheme: TextTheme(
        ), // Pode ser usado para definir estilos de texto globais.
        inputDecorationTheme: InputDecorationTheme( // Define o estilo dos campos de entrada.
          hintStyle: TextStyle(color: AppColors.TextColor2), // Define a cor do texto de dica nos campos de entrada.
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none, // Remove a borda sublinhada padrão quando o campo não está focado.
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none, // Remove a borda sublinhada padrão quando o campo está focado.
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.TextColor1), // Define a cor padrão dos ícones na aplicação.
        appBarTheme: AppBarTheme( // Define o tema da AppBar.
          backgroundColor: AppColors.BgColor, // Define a cor de fundo da AppBar.
          titleTextStyle: TextStyle(color: AppColors.TextColor1, fontSize: 20), // Define o estilo do texto na AppBar.
        ),
      ),
      home: CardSearchScreen(), // Define a tela inicial como a tela de busca de cartas.
    );
  }
}
