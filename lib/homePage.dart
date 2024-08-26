import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

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
        title: const Text('DealMaster'),
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


class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late final ValueNotifier<List<String>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    // Inicialize a formatação de data para português
    initializeDateFormatting('pt_BR', null);
  }

  List<String> _getEventsForDay(DateTime day) {
    // Retorna uma lista de eventos para o dia fornecido.
    return _events[day] ?? [];
  }

  void _addEvent(String event) {
    if (_selectedDay != null) {
      setState(() {
        if (_events[_selectedDay!] != null) {
          _events[_selectedDay!]!.add(event);
        } else {
          _events[_selectedDay!] = [event];
        }
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    }
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            locale: 'pt_BR',  // Define o idioma do calendário para português
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2028, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Mês'
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color.fromRGBO(255, 151, 76, 1), // Cor de fundo para o dia selecionado
                shape: BoxShape.rectangle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,  // Cor do texto para o dia selecionado
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orangeAccent,  // Cor de fundo para o dia atual
                shape: BoxShape.rectangle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white,  // Cor do texto para o dia atual
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddEventDialog() {
    TextEditingController _eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        title: Text(
          'Adicionar Evento',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 151, 76, 1)
          ),
        ),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(
            hintText: 'Digite o evento',
            hintStyle: TextStyle(
              color: Colors.grey
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(255, 151, 76, 1)
              ), // Cor da borda do campo de texto
              borderRadius: BorderRadius.circular(5.0), // Arredondamento da borda
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: Color.fromRGBO(255, 151, 76, 1) // Cor do texto do botão "Cancelar"
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _addEvent(_eventController.text);
              Navigator.pop(context);
            },
            child: Text(
              'Adicionar',
              style: TextStyle(
                color: Color.fromRGBO(255, 151, 76, 1) // Cor do texto do botão "Adicionar"
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late final ValueNotifier<List<String>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<String> _getEventsForDay(DateTime day) {
    // Retorna uma lista de eventos para o dia fornecido.
    return _events[day] ?? [];
  }

  void _addEvent(String event) {
    if (_selectedDay != null) {
      setState(() {
        if (_events[_selectedDay!] != null) {
          _events[_selectedDay!]!.add(event);
        } else {
          _events[_selectedDay!] = [event];
        }
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    }
  }


  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2028, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Mês'
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color.fromRGBO(255, 151, 76, 1), // Cor de fundo para o dia selecionado
                shape: BoxShape.rectangle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,  // Cor do texto para o dia selecionado
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orangeAccent,  // Cor de fundo para o dia atual
                shape: BoxShape.rectangle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white,  // Cor do texto para o dia atual
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddEventDialog() {
    TextEditingController _eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        title: Text(
          'Adicionar Evento',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 151, 76, 1)
          ),
          ),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(
            hintText: 'Digite o evento',
            hintStyle: TextStyle(
              color: Colors.grey
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(255, 151, 76, 1)
                ), // Cor da borda do campo de texto
              borderRadius: BorderRadius.circular(5.0), // Arredondamento da borda
          ),
            ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(
               color: Color.fromRGBO(255, 151, 76, 1) // Cor do texto do botão "Cancelar"
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _addEvent(_eventController.text);
              Navigator.pop(context);
            },
            child: Text(
              'Adicionar',
              style: TextStyle(
                color: Color.fromRGBO(255, 151, 76, 1) // Cor do texto do botão "Cancelar"
              ),
              ),
          ),
        ],
      ),
    );
  }
}*/


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
        ],
      ),
    );
  }
}