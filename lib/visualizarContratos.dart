import 'package:flutter/material.dart';

// Classe responsável por exibir os detalhes de um contrato específico
class VisualizarContrato extends StatelessWidget {
  final String nome;
  final String contratante;
  final String cpfCnpj;
  final String vencimento;

  // Construtor que recebe os dados do contrato
  const VisualizarContrato({super.key, 
    required this.nome,
    required this.contratante,
    required this.cpfCnpj,
    required this.vencimento,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromRGBO(255, 151, 76, 1), // Cor personalizada da AppBar
        title: Text(
          nome, // O título da AppBar é o nome do contrato
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Negrito no título
          ),
        ),
        centerTitle: true, // Centraliza o título da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Espaçamento interno da tela
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinha os textos à esquerda
          children: [
            // Exibe o nome do contrato com estilo destacado
            Text(
              nome,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold, // Negrito para destaque
                color: Colors.black87, // Cor do texto
              ),
            ),
            const SizedBox(height: 24.0), // Espaçamento vertical
            // Exibe o contratante do contrato com um rótulo
            Text(
              'Contratante:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700], // Cor mais suave para o rótulo
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              contratante,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500, // Negrito moderado
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20.0), // Espaçamento vertical
            // Exibe o CPF/CNPJ do contratante com um rótulo
            Text(
              'CPF/CNPJ:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              cpfCnpj,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20.0),

            // ebxie a data de vencimento do contrato com um rotulo
            Text(
              'Data de Vencimento:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              vencimento,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Spacer(), // Espaçamento flexível para empurrar o botão para o final da tela
            // Botão estilizado para realizar uma ação no contrato
            ElevatedButton(
              onPressed: () {
                // Ação a ser executada (exemplo: editar contrato)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromRGBO(255, 151, 76, 1), // Cor do botão atualizada
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Bordas arredondadas
                ),
              ),
              child: const Text(
                'Editar Contrato',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Cor do texto no botão
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
