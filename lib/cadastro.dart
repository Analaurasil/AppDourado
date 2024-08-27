import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  String? _tipoUsuario = 'FUNCIONARIO';
  String _nome = '';
  String _senha = '';
  String _email = '';
  String _cnpj = '';
  String _empresaNome = '';

  final Dio _dio = Dio();

  Future<void> _enviarDados() async {
    final dados = {
      "nome": _nome,
      "senha": _senha,
      "email": _email,
      "tipo": _tipoUsuario,
      "empresa": {
        "cnpj": _cnpj,
        "nome": _empresaNome,
      }
    };

    try {
      final response = await _dio.post(
        'https://api-deal-master-app.onrender.com/api/v1/users/register',
        data: dados,
      );
      print('Resposta: ${response.data}');

      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Usuário cadastrado com sucesso!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _tipoUsuario = 'FUNCIONARIO';
                  _nome = '';
                  _senha = '';
                  _email = '';
                  _cnpj = '';
                  _empresaNome = '';
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    } catch (e) {
      print('Erro ao enviar dados: $e');

      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: const Text('Erro ao enviar dados. Tente novamente.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.primaryColor;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CADASTRO',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tipo de Usuário:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  
                ),
              ),
              RadioListTile<String>(
                title: const Text('Funcionário'),
                value: 'FUNCIONARIO',
                groupValue: _tipoUsuario,
                activeColor: theme.primaryColor,
                onChanged: (String? value) {
                  setState(() {
                    _tipoUsuario = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Gerente'),
                value: 'GERENTE',
                groupValue: _tipoUsuario,
                activeColor: theme.primaryColor,
                onChanged: (String? value) {
                  setState(() {
                    _tipoUsuario = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _nome = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nome',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
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
                    _email = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
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
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                  labelStyle: TextStyle(color: borderColor),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
                          const Text(
                'Dados da Empresa:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _empresaNome = value;
                              });
                            },
                decoration: InputDecoration(
                  labelText: 'Nome da empresa',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
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
                                _cnpj = value;
                              });
                            },
                decoration: InputDecoration(
                  labelText: 'CNPJ',
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                  ),
                  labelStyle: TextStyle(color: borderColor),
                ),
              ),
              const SizedBox(height: 20),             
              ElevatedButton(
                onPressed: _enviarDados,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}