import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';

class FormContrato extends StatefulWidget {
  const FormContrato({super.key});

  @override
  _FormContratoState createState() => _FormContratoState();
}

class _FormContratoState extends State<FormContrato> {
  String? _selectedOption = 'PJ';
  Uint8List? _contractorSignature;
  Uint8List? _contractedSignature;
  String _nome = '';
  String _cpfCnpj = '';
  String _texto = '';
  String _dataVencimento = '';

  void _enviarRequisicao() async {
    final Map<String, dynamic> data = {
      "parceiro": {
        "nome": _nome,
        "tipo": _selectedOption,
        "cpfCnpj": _cpfCnpj,
      },
      "texto": _texto,
      "dataVencimento": _dataVencimento,
    };

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('auth_token');

    try {
      final dio = Dio();
      final response = await dio.post(
        'https://api-deal-master-app.onrender.com/api/v1/users/contract/add',
        data: data,
        options: Options(
          headers: {
            'Autorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Contrato salvo com sucesso');
      } else {
        print('Falha ao salvar contrato');
      }
    } catch (e) {
      print('Erro ao enviar requisição: $e');
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSectionTitle(context, 'CONTRATANTE'),
            _buildRadioOptions(),
            TextField(
              onChanged: (value) {
                setState(() {
                  _nome = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nome',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                labelStyle: TextStyle(color: laranja),
              ),
            ),
            const SizedBox(height: 5.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _cpfCnpj = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'CNPJ/CPF',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                labelStyle: TextStyle(color: laranja),
              ),
            ),
            const SizedBox(height: 20.0),
            _buildSectionTitle(context, 'CONTRATADA'),
            const SizedBox(height: 5.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                labelStyle: TextStyle(color: laranja),
              ),
            ),
            const SizedBox(height: 5.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'CNPJ',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                labelStyle: TextStyle(color: laranja),
              ),
            ),
            const SizedBox(height: 5.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _texto = value;
                });
              },
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Insira o texto do contrato aqui:',
              ),
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _dataVencimento = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Data',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranja),
                ),
                labelStyle: TextStyle(color: laranja),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildSignatureField(
                    'Assinatura do Contratante',
                    _contractorSignature,
                    () {
                      _openSignaturePad(context, (signature) {
                        setState(() {
                          _contractorSignature = signature;
                        });
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: _buildSignatureField(
                    'Assinatura da Contratada',
                    _contractedSignature,
                    () {
                      _openSignaturePad(context, (signature) {
                        setState(() {
                          _contractedSignature = signature;
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _enviarRequisicao,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildRadioOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ListTile(
            title: const Text('PJ'),
            leading: Radio<String>(
              value: 'CNPJ',
              groupValue: _selectedOption,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('PF'),
            leading: Radio<String>(
              value: 'CPF',
              groupValue: _selectedOption,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignatureField(
      String label, Uint8List? signature, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: signature != null
            ? Image.memory(signature)
            : Center(child: Text(label)),
      ),
    );
  }

  void _openSignaturePad(
      BuildContext context, Function(Uint8List) onSignatureSelected) {
    final SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );

    showDialog(
      context: context,
      builder: (context) {
        return SignatureDialog(
          controller: controller,
          onSignatureSelected: onSignatureSelected,
        );
      },
    );
  }
}

class SignatureDialog extends StatelessWidget {
  final SignatureController controller;
  final Function(Uint8List) onSignatureSelected;

  const SignatureDialog({
    Key? key,
    required this.controller,
    required this.onSignatureSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Assine aqui'),
      content: Container(
        width: 300,
        height: 300,
        color: Colors.grey[200],
        child: Signature(
          controller: controller,
          backgroundColor: Colors.transparent,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.clear();
          },
          child: const Text('Limpar'),
        ),
        TextButton(
          onPressed: () async {
            final signature = await controller.toPngBytes();
            if (signature != null) {
              onSignatureSelected(signature);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}