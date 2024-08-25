import 'package:dealmaster/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:dealmaster/homePage.dart';
import 'package:dealmaster/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: estilosDoTema(),
      home: HomePage(),
    );
  }

  ThemeData estilosDoTema() {
    return ThemeData(
      primaryColor: const Color.fromRGBO(255, 151, 76, 1),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Color.fromRGBO(255, 151, 76, 1),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(255, 151, 76, 1),
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor: const Color.fromRGBO(255, 151, 76, 1),
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(255, 151, 76, 1),  // Cor de fundo do FAB
          foregroundColor: Colors.white,  // Cor do ícone no FAB
          shape: RoundedRectangleBorder(  // Forma personalizada do FAB
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 8.0,  // Elevação do FAB
        ),
    );
  }
}