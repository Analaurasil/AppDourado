import 'package:flutter/material.dart';

// Classe responsável pela tela de relatório de contratos
class TelaRelatorio extends StatelessWidget {
  // Lista fictícia de dados de contratos que farão parte do relatório
  final List<Map<String, dynamic>> _relatorioDados = [
    {'categoria': 'Contratos Vigentes', 'quantidade': 10},
    {'categoria': 'Contratos Finalizados', 'quantidade': 5},
    {'categoria': 'Contratos Pendente de Assinatura', 'quantidade': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório de Contratos'), // Título da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Define o espaçamento da tela
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinhamento dos textos à esquerda
          children: [
            // Título da seção de relatório
            Text(
              'Visão Geral',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16.0), // Espaçamento entre o título e o gráfico

            // Exibe um gráfico simplificado (representado por um widget ListView neste caso)
            Expanded(
              child: ListView.builder(
                itemCount:
                    _relatorioDados.length, // Número de itens no relatório
                itemBuilder: (context, index) {
                  // Cada item é uma categoria de contratos com uma barra representando a quantidade
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _relatorioDados[index]['categoria'],
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          height: 10,
                          width: _relatorioDados[index]['quantidade'] * 20.0,
                          color: Colors.orangeAccent, // Cor da barra do gráfico
                        ),
                        Text(
                          '${_relatorioDados[index]['quantidade']}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0), // Espaçamento entre o gráfico e os botões

            // Botão para gerar um relatório completo em PDF ou outro formato
            ElevatedButton.icon(
              onPressed: () {
                // Ação de gerar um relatório completo
              },
              icon: Icon(Icons.picture_as_pdf), // Ícone de PDF
              label: Text('Gerar Relatório Completo'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(255, 151, 76, 1), // Cor personalizada
                padding: EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0), // Padding
                textStyle: TextStyle(fontSize: 18), // Estilo do texto do botão
              ),
            ),

            SizedBox(height: 10.0),

            // Botão para exportar o relatório
            ElevatedButton.icon(
              onPressed: () {
                // Ação de exportar o relatório
              },
              icon: Icon(Icons.file_download), // Ícone de download
              label: Text('Exportar Relatório'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(255, 151, 76, 1), // Cor personalizada
                padding: EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0), // Padding
                textStyle: TextStyle(fontSize: 18), // Estilo do texto do botão
              ),
            ),
          ],
        ),
      ),
    );
  }
}
