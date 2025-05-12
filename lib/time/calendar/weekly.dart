import 'package:flutter/material.dart';
import '../../menu.dart';
import '../../settings.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'daily.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  late DateTime currentWeek;
  late List<DateTime> weekDates;

  @override
  void initState() {
    super.initState();
    currentWeek = DateTime.now();
    weekDates = _generateWeekDates(currentWeek);
  }

  List<DateTime> _generateWeekDates(DateTime date) {
    DateTime sunday = date.subtract(Duration(days: date.weekday % 7));

    List<DateTime> dates = [];
    for (int i = 0; i < 7; i++) {
      dates.add(sunday.add(Duration(days: i)));
    }
    
    return dates;
  }

  void _changeWeek(int offset) {
    setState(() {
      currentWeek = currentWeek.add(Duration(days: 7 * offset));
      weekDates = _generateWeekDates(currentWeek);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => _changeWeek(-1),
            ),
            Text(
              '${_monthName(weekDates.first.month)} ${weekDates.first.day} - ${_monthName(weekDates.last.month)} ${weekDates.last.day}, ${weekDates.last.year}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => _changeWeek(1),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              DateTime date = weekDates[index];
              bool isToday = _isToday(date);
              
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isToday ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
                    width: isToday ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _dayName(date.weekday),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isToday ? Theme.of(context).colorScheme.primary : Colors.black87,
                        ),
                      ),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          color: isToday ? Theme.of(context).colorScheme.primary : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  title: Text('No events scheduled'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyPage(selectedDate: date),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  String _dayName(int weekday) {
    return [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ][weekday - 1];
  }

  String _monthName(int monthNumber) {
    return [
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
    ][monthNumber - 1];
  }
}

class WeeklyPage extends StatefulWidget {
  const WeeklyPage({super.key});

  @override
  State<WeeklyPage> createState() => _WeeklyPageState();
}

class _WeeklyPageState extends State<WeeklyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Weekly View",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: WeeklyScreen(),
        ),
      ),
    );
  }
}

