import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class FormContrato extends StatefulWidget {
  @override
  _FormContratoState createState() => _FormContratoState();
}

class _FormContratoState extends State<FormContrato> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedOption = 'PJ';
  Uint8List? _contractorSignature;
  Uint8List? _contractedSignature;
  String _nome = '';
  String _cpfCnpj = '';
  String _texto = '';
  String _dataVencimento = '';
  String _tipoParceiro = 'CPF'; // ou 'CNPJ'

  void _sendRequest() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> data = {
        "parceiro": {
          "nome": _nome,
          "tipo": _tipoParceiro,
          "cpfCnpj": _cpfCnpj,
        },
        "texto": _texto,
        "dataVencimento": _dataVencimento,
      };

      try {
        final dio = Dio();
        final response = await dio.post(
          'https://seu-endereco-api.com/contratos',
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );

        if (response.statusCode == 200) {
          // Requisição bem-sucedida
          print('Contrato salvo com sucesso');
        } else {
          // Falha na requisição
          print('Falha ao salvar contrato');
        }
      } catch (e) {
        print('Erro ao enviar requisição: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final laranja = theme.primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrato'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CPF/CNPJ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CPF/CNPJ';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cpfCnpj = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Texto do Contrato'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o texto do contrato';
                  }
                  return null;
                },
                onSaved: (value) {
                  _texto = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data de Vencimento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de vencimento';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dataVencimento = value!;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _sendRequest,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}