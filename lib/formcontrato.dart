import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';

void main() => runApp(SignatureApp());

class SignatureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormContrato(),
    );
  }
}

class FormContrato extends StatefulWidget {
  @override
  _FormContratoState createState() => _FormContratoState();
}

class _FormContratoState extends State<FormContrato> {
  String? _selectedOption = 'PJ';
  Uint8List? _contractorSignature;
  Uint8List? _contractedSignature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrato'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CONTRATANTE',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('PJ'),
                    leading: Radio<String>(
                      value: 'PJ',
                      groupValue: _selectedOption,
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
                    title: Text('PF'),
                    leading: Radio<String>(
                      value: 'PF',
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 5.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'CNPJ/CPF',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'CONTRATADA',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 5.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 5.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'CNPJ',
              ),
            ),
            SizedBox(height: 5.0),
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Insira o texto do contrato aqui:',
              ),
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 20.0),
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
                SizedBox(width: 10.0),
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Ação de salvar
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
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
            : Center(child: Text('$label')),
      ),
    );
  }

  void _openSignaturePad(
      BuildContext context, Function(Uint8List) onSignatureSelected) {
    final SignatureController _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Assine aqui'),
          content: Signature(
            controller: _controller,
            width: 300,
            height: 300,
            backgroundColor: Colors.grey[200]!,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _controller.clear();
              },
              child: Text('Limpar'),
            ),
            TextButton(
              onPressed: () async {
                final signature = await _controller.toPngBytes();
                if (signature != null) {
                  onSignatureSelected(signature);
                }
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
