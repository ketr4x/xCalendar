import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../menu.dart';
import '../../settings.dart';
import 'monthly.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  late DateTime selectedDate;
  late List<Event> dayEvents;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    dayEvents = _generateMockEvents(selectedDate);
  }

  List<Event> _generateMockEvents(DateTime day) {
    return [
      Event(
        title: 'Test',
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 10, minute: 30),
        color: Colors.blue.shade300,
      ),
    ];
  }

  void _changeDay(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
      dayEvents = _generateMockEvents(selectedDate);
    });
  }

  String _formatDate(DateTime date) {
    List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => _changeDay(-1),
            ),
            Text(
              _formatDate(selectedDate),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => _changeDay(1),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: dayEvents.length,
            itemBuilder: (context, index) {
              final event = dayEvents[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Container(
                      width: 12,
                      decoration: BoxDecoration(
                        color: event.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    title: Text(
                      event.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${_formatTimeOfDay(event.startTime)} - ${_formatTimeOfDay(event.endTime)}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      // TODO: Implement event editing or detailed view
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              // TODO: Implement adding new event
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class Event {
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Color color;

  Event({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.color,
  });
}

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    BottomNavBar.handleNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Daily View",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: 'Monthly View',
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MonthlyPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: DailyScreen(),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
