import 'package:flutter/material.dart';

class TelaRelatorio extends StatelessWidget {
  final List<Map<String, dynamic>> _relatorioDados = [
    {'categoria': 'Contratos Vigentes', 'quantidade': 10},
    {'categoria': 'Contratos Finalizados', 'quantidade': 5},
    {'categoria': 'Contratos Pendente de Assinatura', 'quantidade': 3},
  ];

  TelaRelatorio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Contratos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visão Geral',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _relatorioDados.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _relatorioDados[index]['categoria'],
                          style: const TextStyle(fontSize: 18),
                        ),
                        Container(
                          height: 10,
                          width: _relatorioDados[index]['quantidade'] * 20.0,
                          color: Colors.orangeAccent,
                        ),
                        Text(
                          '${_relatorioDados[index]['quantidade']}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Gerar Relatório Completo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 151, 76, 1),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.file_download),
              label: const Text('Exportar Relatório'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 151, 76, 1),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
