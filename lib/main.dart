import 'package:dealmaster/formcontrato.dart';
import 'package:dealmaster/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dealmaster/login.dart';
import 'package:dealmaster/cadastro.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const TelaLogin(),
      ),
      GoRoute(
        path: '/cadastro',
        builder: (context, state) => const TelaCadastro(),
      ),
      GoRoute(path: '/home',
      builder: (context , state) => const HomePage(),
      ),
       GoRoute(
      path: '/formcontrato',
      builder: (context, state) => const FormContrato(),
    ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'App Dourado',
      theme: estilosDoTema(),
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
      // Definindo um tema personalizado para a BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(255, 151, 76, 1), // Cor de fundo da barra de navegação inferior
          selectedItemColor: Colors.white, // Cor do item selecionado
          unselectedItemColor: Colors.white70, // Cor dos itens não selecionados
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold), // Estilo do rótulo selecionado
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal), // Estilo do rótulo não selecionado
          elevation: 10.0, // Elevação da barra de navegação inferior
        ),
      
    );
  }
}