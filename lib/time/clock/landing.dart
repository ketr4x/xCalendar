import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import '../../widgets/drawer.dart';

class ClockLandingPage extends StatefulWidget {
  const ClockLandingPage({super.key});

  @override
  State<ClockLandingPage> createState() => _ClockLandingPageState();
}

class _ClockLandingPageState extends State<ClockLandingPage> {
  int _selectedIndex = 1;
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  String _selectedTimezone = DateTime.now().timeZoneName;
  List<String> _availableTimezones = [];
  List<String> _favoriteTimezones = [];
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredTimezones = [];

  @override
  void initState() {
    super.initState();
    _initializeTimezones();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _saveTimezones() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('timezones', _favoriteTimezones);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving timezones: $e');
      }
    }
  }

  Future<void> _initializeTimezones() async {
    try {
      tz_data.initializeTimeZones();
      _availableTimezones = tz.timeZoneDatabase.locations.keys.toList();
      _availableTimezones.sort();
      _filteredTimezones = List.from(_availableTimezones);

      String localTimezone = 'Europe/Warsaw';

      try {
        final localOffset = DateTime.now().timeZoneOffset.inMinutes;

        final now = DateTime.now();
        final possibleMatches = _availableTimezones.where((timezone) {
          try {
            final location = tz.getLocation(timezone);
            final tzNow = tz.TZDateTime.from(now.toUtc(), location);
            final tzOffset = tzNow.timeZoneOffset.inMinutes;
            return tzOffset == localOffset;
          } catch (_) {
            return false;
          }
        }).toList();

        if (possibleMatches.isNotEmpty) {
          final currentTzName = now.timeZoneName;
          final exactMatch = possibleMatches.firstWhere(
            (tz) => tz.contains(currentTzName),
            orElse: () => possibleMatches.first,
          );
          localTimezone = exactMatch;
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error detecting timezone: $e');
        }
      }

      var prefs = await SharedPreferences.getInstance();
      var savedTimezones = prefs.getStringList('timezones');

      setState(() {
        _selectedTimezone = localTimezone;
        if (savedTimezones != null && savedTimezones.isNotEmpty) {
          _favoriteTimezones = savedTimezones;
          _favoriteTimezones.remove(localTimezone);
        } else {
          _favoriteTimezones = [
            'America/New_York',
            'Europe/London',
            'Asia/Tokyo',
            'Australia/Sydney',
          ].where((tz) => tz != localTimezone).take(3).toList();
          _saveTimezones();
        }
      });
    } catch (e) {
      _availableTimezones = ['Europe/Warsaw', 'America/New_York', 'Asia/Tokyo'];
      _filteredTimezones = List.from(_availableTimezones);
    }
  }

  DateTime _getTimeInZone(String timezone) {
    try {
      final location = tz.getLocation(timezone);
      final nowUtc = DateTime.now().toUtc();
      final tzDateTime = tz.TZDateTime.from(nowUtc, location);
      return DateTime(
        tzDateTime.year,
        tzDateTime.month,
        tzDateTime.day,
        tzDateTime.hour,
        tzDateTime.minute,
        tzDateTime.second,
      );
    } catch (e) {
      return DateTime.now();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    BottomNavBar.handleNavigation(context, index);
  }

  void _showTimezoneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Select Timezone'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search timezones...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setStateDialog(() {
                          if (value.isEmpty) {
                            _filteredTimezones = List.from(_availableTimezones);
                          } else {
                            _filteredTimezones = _availableTimezones
                                .where((timezone) =>
                                    timezone.toLowerCase().contains(value.toLowerCase()))
                                .toList();
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredTimezones.length,
                        itemBuilder: (context, index) {
                          final timezone = _filteredTimezones[index];
                          return ListTile(
                            title: Text(timezone),
                            subtitle: Text(
                              DateFormat('HH:mm').format(_getTimeInZone(timezone)),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                _favoriteTimezones.contains(timezone)
                                    ? Icons.star
                                    : Icons.star_border,
                              ),
                              onPressed: () {
                                setStateDialog(() {
                                  if (_favoriteTimezones.contains(timezone)) {
                                    _favoriteTimezones.remove(timezone);
                                  } else {
                                    _favoriteTimezones.add(timezone);
                                  }
                                });
                                setState(() {});
                                _saveTimezones();
                              },
                            ),
                            onTap: () {
                              setState(() {
                                _selectedTimezone = timezone;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      _searchController.clear();
      setState(() {
        _filteredTimezones = List.from(_availableTimezones);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final timeInSelectedZone = _getTimeInZone(_selectedTimezone);
    final formattedTime = DateFormat('HH:mm:ss').format(timeInSelectedZone);
    final formattedDate = DateFormat('EEEE, d MMMM y').format(timeInSelectedZone);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Clock",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      drawer: AppDrawer(category: 'Time'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 280,
                      height: 280,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CustomPaint(
                        painter: ClockFacePainter(
                          hour: timeInSelectedZone.hour,
                          minute: timeInSelectedZone.minute,
                          second: timeInSelectedZone.second,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _selectedTimezone,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            if (_favoriteTimezones.isNotEmpty) const Divider(),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: _favoriteTimezones.map((timezone) {
                final time = _getTimeInZone(timezone);
                return SmallClockWidget(
                  timezone: timezone,
                  time: time,
                  onRemove: () {
                    setState(() {
                      _favoriteTimezones.remove(timezone);
                    });
                    _saveTimezones();
                  },
                  onSelect: () {
                    setState(() {
                      _selectedTimezone = timezone;
                    });
                  },
                );
              }).toList(),
            ),

            if (_favoriteTimezones.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Manage Timezones'),
                  onPressed: _showTimezoneDialog,
                ),
              ),

            if (_favoriteTimezones.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Add Other Timezones',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Add additional timezones to display smaller clocks below',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Manage Timezones'),
                          onPressed: _showTimezoneDialog,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class SmallClockWidget extends StatelessWidget {
  final String timezone;
  final DateTime time;
  final VoidCallback onRemove;
  final VoidCallback onSelect;

  const SmallClockWidget({
    super.key,
    required this.timezone,
    required this.time,
    required this.onRemove,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      timezone.split('/').last.replaceAll('_', ' '),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: onRemove,
                    child: const Icon(Icons.close, size: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: CustomPaint(
                painter: ClockFacePainter(
                  hour: time.hour,
                  minute: time.minute,
                  second: time.second,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('HH:mm').format(time),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat('E').format(time),
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ClockFacePainter extends CustomPainter {
  final int hour;
  final int minute;
  final int second;
  final Color color;

  ClockFacePainter({
    required this.hour,
    required this.minute,
    required this.second,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;
    final center = Offset(centerX, centerY);

    final hourMarkerPaint = Paint()
      ..color = color
      ..strokeWidth = 2;

    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (3.14159265359 / 180);
      final outerX = centerX + (radius - 10) * sin(angle);
      final outerY = centerY - (radius - 10) * cos(angle);
      final innerX = centerX + (radius - 20) * sin(angle);
      final innerY = centerY - (radius - 20) * cos(angle);

      canvas.drawLine(
        Offset(innerX, innerY),
        Offset(outerX, outerY),
        hourMarkerPaint,
      );
    }

    final hourAngle = (hour % 12 + minute / 60) * 30 * (3.14159265359 / 180);
    final hourHandLength = radius * 0.5;
    final hourHandX = centerX + hourHandLength * sin(hourAngle);
    final hourHandY = centerY - hourHandLength * cos(hourAngle);

    final hourHandPaint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandPaint);

    final minuteAngle = minute * 6 * (3.14159265359 / 180);
    final minuteHandLength = radius * 0.7;
    final minuteHandX = centerX + minuteHandLength * sin(minuteAngle);
    final minuteHandY = centerY - minuteHandLength * cos(minuteAngle);

    final minuteHandPaint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minuteHandPaint);

    final secondAngle = second * 6 * (3.14159265359 / 180);
    final secondHandLength = radius * 0.8;
    final secondHandX = centerX + secondHandLength * sin(secondAngle);
    final secondHandY = centerY - secondHandLength * cos(secondAngle);

    final secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondHandPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
