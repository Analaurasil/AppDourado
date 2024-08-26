import 'package:flutter/material.dart';
import 'visualizar_contratos.dart';

class MeusContratos extends StatelessWidget {
  final List<Map<String, String>> _contracts = [
    {
      'nome': 'Contrato A',
      'contratante': 'Empresa XYZ',
      'cpfCnpj': '12.345.678/0001-99',
      'vencimento': '15/12/2024'
    },
    {
      'nome': 'Contrato B',
      'contratante': 'Empresa ABC',
      'cpfCnpj': '98.765.432/0001-22',
      'vencimento': '22/02/2024'
    },
    {
      'nome': 'Contrato C',
      'contratante': 'Empresa QWE',
      'cpfCnpj': '11.222.333/0001-44',
      'vencimento': '01/08/2024'
    },
  ];

  MeusContratos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 151, 76, 1),
        title: const Text(
          'Meus Contratos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _contracts.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: Icon(Icons.description, color: Colors.white),
                ),
                title: Text(
                  _contracts[index]['nome']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _contracts[index]['contratante']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Vencimento: ${_contracts[index]['vencimento']!}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[700],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VisualizarContrato(
                        nome: _contracts[index]['nome']!,
                        contratante: _contracts[index]['contratante']!,
                        cpfCnpj: _contracts[index]['cpfCnpj']!,
                        vencimento: _contracts[index]['vencimento']!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
