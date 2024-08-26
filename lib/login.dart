import 'package:dealmaster/main.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  String _email = '';
  String _senha = '';
  final Dio _dio = Dio();

  Future<void> _login() async {
    final Map<String, dynamic> dados = {
      'email': _email,
      'senha': _senha,
    };

    try {
      final response = await _dio.post(
        'https://api-deal-master-app.onrender.com/api/v1/users/login',
        data: dados,
      );
      final token = response.data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      print('Token salvo: $token');
      
    } catch (e) {
      print('Erro ao enviar dados: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
   final theme = Theme.of(context);
    final borderColor = theme.primaryColor;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: borderColor,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                  labelStyle: TextStyle(color: borderColor),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _senha = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Senha',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                  labelStyle: TextStyle(color: borderColor),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: 200, 
                  child: ElevatedButton(
                    onPressed:_login,
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18), 
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: 200, 
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/cadastro');
                    },
                    child: Text(
                      'Registrar',
                      style: TextStyle(fontSize: 18), 
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}