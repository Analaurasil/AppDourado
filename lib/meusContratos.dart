import 'package:flutter/material.dart';
import 'visualizarContratos.dart'; // Importa a página de visualização de contratos

// Classe responsável pela tela "Meus Contratos"
class MeusContratos extends StatelessWidget {
  // Lista fictícia de contratos com contratante, CPF/CNPJ e data de vencimento
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
        // Estilização da AppBar de acordo com o protótipo
        backgroundColor: const Color.fromRGBO(255, 151, 76, 1), // Cor personalizada
        title: const Text(
          'Meus Contratos',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Negrito no título
            fontSize: 20, // Aumenta o tamanho da fonte
          ),
        ), // Título da AppBar
        centerTitle: true, // Centraliza o título da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento nas bordas
        child: ListView.builder(
          itemCount: _contracts.length, // Define o número de contratos na lista
          itemBuilder: (context, index) {
            // Cada item da lista é um ListTile estilizado
            return Card(
              elevation: 4, // Sombra para destacar o cartão
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0), // Espaçamento vertical
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15.0), // Bordas arredondadas
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  // Usando um avatar circular com o ícone de contrato
                  backgroundColor: Colors.orangeAccent,
                  child: Icon(Icons.description, color: Colors.white),
                ),
                title: Text(
                  _contracts[index]['nome']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Negrito no nome do contrato
                  ),
                ), // Nome do contrato
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _contracts[index]
                          ['contratante']!, // Contratante do contrato
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Vencimento: ${_contracts[index]['vencimento']!}', // Data de vencimento
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios, // Ícone de seta para frente
                  color: Colors.grey[700],
                ), // Ícone para indicar que pode ser clicado
                onTap: () {
                  // Quando o usuário clicar, navega para a tela de detalhes do contrato
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VisualizarContrato(
                        // Passa os detalhes do contrato para a próxima tela
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
