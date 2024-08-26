import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';

class FormContrato extends StatefulWidget {
  const FormContrato({super.key});

  @override
  _FormContratoState createState() => _FormContratoState();
}

class _FormContratoState extends State<FormContrato> {
  String? _selectedOption = 'PJ';
  Uint8List? _contractorSignature;
  Uint8List? _contractedSignature;

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
            const TextField(
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Insira o texto do contrato aqui:',
              ),
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 20.0),
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
              onPressed: () {
                
              },
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
              value: 'PJ',
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
              value: 'PF',
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