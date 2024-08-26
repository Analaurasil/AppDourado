import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    ContractsPage(),
    const AgendaPage(),
    ReportPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('DealMaster'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () {},
            )
          ]),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Contratos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Relatório',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

    initializeDateFormatting('pt_BR', null);
  }

  List<String> _getEventsForDay(DateTime day) {
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
            locale: 'pt_BR',
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2028, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
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
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color.fromRGBO(255, 151, 76, 1),
                shape: BoxShape.rectangle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.rectangle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white,
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
        child: const Icon(Icons.add),
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
        title: const Text(
          'Adicionar Evento',
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 151, 76, 1)),
        ),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(
            hintText: 'Digite o evento',
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromRGBO(255, 151, 76, 1)),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color.fromRGBO(255, 151, 76, 1)),
            ),
          ),
          TextButton(
            onPressed: () {
              _addEvent(_eventController.text);
              Navigator.pop(context);
            },
            child: const Text(
              'Adicionar',
              style: TextStyle(color: Color.fromRGBO(255, 151, 76, 1)),
            ),
          ),
        ],
      ),
    );
  }
}

class ContractsPage extends StatelessWidget {
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
        title: const Text('Contratos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _contracts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.description),
            title: Text(_contracts[index]),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/formcontrato');
        },
        tooltip: 'Adicionar novo contrato',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ReportPage extends StatelessWidget {
  final List<String> _reports = [
    'Total de contratos: 15',
    'Contratos vigentes: 10',
    'Contratos finalizados: 5',
  ];

  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Relatório de Atividades',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _reports.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.bar_chart),
                title: Text(_reports[index]),
              );
            },
          ),
          const SizedBox(height: 20.0),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Gerar Relatório',
            child: const Icon(Icons.download_rounded),
          ),
        ],
      ),
    );
  }
}
