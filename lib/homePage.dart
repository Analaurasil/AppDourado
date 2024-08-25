import 'package:flutter/material.dart';

// Classe principal que define a página inicial como um StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Estado que mantém o índice da aba selecionada
  int _selectedIndex = 1;

  // Lista de páginas que serão exibidas conforme o usuário navega entre as abas
  final List<Widget> _pages = [
     ContractsPage(), // Página de Contratos
     AgendaPage(), // Página da Agenda
     ReportPage(), // Página de Relatório
  ];

  // Função chamada quando o usuário seleciona uma aba no BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =
          index; // Atualiza o índice selecionado, o que provoca a exibição da página correspondente
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar que exibe o título da aplicação no topo
      appBar: AppBar(
        title: Text('DealMaster'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.menu_outlined),
            onPressed: (){
              
            },
          )
        ]
      ),
      // O corpo da tela será a página correspondente ao índice selecionado
      body: _pages[_selectedIndex],
      // BottomNavigationBar que permite ao usuário navegar entre as páginas
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // Item do BottomNavigationBar para a página de Contratos
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined), // Ícone da aba
            label: 'Contratos', // Texto da aba
          ),
          // Item do BottomNavigationBar para a página de Agenda
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), // Ícone da aba
            label: 'Agenda', // Texto da aba
          ),
          // Item do BottomNavigationBar para a página de Relatório
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart), // Ícone da aba
            label: 'Relatório', // Texto da aba
          ),
        ],
        currentIndex:
            _selectedIndex, // Índice atual que controla qual página é exibida
        //selectedItemColor: Color.fromARGB(255, 255, 255, 255), // Cor do ícone e texto da aba selecionada
        onTap:
            _onItemTapped, // Chama a função quando o usuário seleciona uma aba
      ),
    );
  }
}

// Página da Agenda
class AgendaPage extends StatelessWidget {
  // Lista de compromissos fictícios
  final List<String> _appointments = [
    'Reunião com o cliente A - 10:00 AM',
    'Revisão de contrato B - 01:00 PM',
    'Call com a equipe - 03:00 PM'
  ];

   AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Número de itens na lista
      itemCount: _appointments.length,
      // Constrói cada item da lista com base no índice
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.event), // Ícone na frente de cada compromisso
          title: Text(_appointments[index]), // Texto do compromisso
        );
      },
    );
  }
}

// Página de Contratos
class ContractsPage extends StatelessWidget {
  // Lista de contratos fictícios
  final List<String> _contracts = [
    'Contrato A - Vigente',
    'Contrato B - Pendente de Assinatura',
    'Contrato C - Finalizado'
  ];

   ContractsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contratos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        // Número de contratos na lista
        itemCount: _contracts.length,
        // Constrói cada item da lista com base no índice
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.description), // Ícone na frente de cada contrato
            title: Text(_contracts[index]), // Texto do contrato
            trailing: const Icon(Icons.arrow_forward), // Ícone de seta à direita
            onTap: () {
              // Lógica para navegar para os detalhes do contrato
              // Ainda não implementado
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para adicionar um novo contrato 
          //print('Botão flutuante clicado!');
        },
        child: Icon(Icons.add),
        tooltip: 'Adicionar novo contrato',
      ),
    );
  }
}

// Página de Relatório
class ReportPage extends StatelessWidget {
  // Lista de relatórios simples
  final List<String> _reports = [
    'Total de contratos: 15',
    'Contratos vigentes: 10',
    'Contratos finalizados: 5',
  ];

  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Espaçamento ao redor do conteúdo
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinhamento do conteúdo à esquerda
        children: [
          // Título do relatório
          Text(
            'Relatório de Atividades',
            style: Theme.of(context)
                .textTheme
                .headlineSmall, // Usando o estilo de texto padrão do tema
          ),
          const SizedBox(
              height:
                  10.0), // Espaçamento entre o título e a lista de relatórios
          // Lista dos relatórios
          ListView.builder(
            shrinkWrap: true, // Encolhe a lista para caber no espaço disponível
            itemCount: _reports.length, // Número de relatórios na lista
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons
                    .bar_chart), // Ícone de gráfico ao lado de cada relatório
                title: Text(_reports[index]), // Texto do relatório
              );
            },
          ),
          const SizedBox(height: 20.0), // Espaçamento antes do botão
          // Botão para gerar relatório completo
          FloatingActionButton(
            onPressed: () {
            // Lógica para adicionar um novo contrato 
            //print('Botão flutuante clicado!');
            },
            child: Icon(Icons.download_rounded),
            tooltip: 'Gerar Relatório',
          ),
          /*ElevatedButton(
            onPressed: () {
              // Ação para gerar um relatório completo
              // Ainda não implementado
            },
            child: const Text('Gerar Relatório Completo'), // Texto do botão
          ),*/
        ],
      ),
    );
  }
}
