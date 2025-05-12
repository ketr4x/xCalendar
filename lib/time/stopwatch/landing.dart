import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/drawer.dart';

class SWLandingPage extends StatefulWidget {
  const SWLandingPage({super.key});

  @override
  State<SWLandingPage> createState() => _SWLandingPageState();
}

class _SWLandingPageState extends State<SWLandingPage> {
  int _selectedIndex = 2;
  bool _isRunning = false;
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  List<Duration> _laps = [];
  Duration _previousLapTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _resetStopwatch();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _resetStopwatch() {
    _stopTimer();
    setState(() {
      _stopwatch = Stopwatch();
      _laps = [];
      _previousLapTime = Duration.zero;
      _isRunning = false;
    });
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
      _startTimer();
    });
  }

  void _stopStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
      _stopTimer();
    });
  }

  void _recordLap() {
    if (_isRunning) {
      final currentLapTime = _stopwatch.elapsed;
      final lapDuration = currentLapTime - _previousLapTime;
      
      setState(() {
        _laps.insert(0, lapDuration);
        _previousLapTime = currentLapTime;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    BottomNavBar.handleNavigation(context, index);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = (duration.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds.$milliseconds';
    } else {
      return '$minutes:$seconds.$milliseconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = _stopwatch.elapsed;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Stopwatch",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      drawer: AppDrawer(category: 'Time'),
      body: Column(
        children: [
          const SizedBox(height: 30),
          
          // Stopwatch display
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
                    color: Colors.black.withOpacity(0.2),
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
                      painter: StopwatchFacePainter(
                        milliseconds: elapsed.inMilliseconds,
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
          
          // Digital display
          Text(
            _formatDuration(elapsed),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _resetStopwatch,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.refresh, size: 30),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: _isRunning ? _stopStopwatch : _startStopwatch,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(24),
                  backgroundColor: _isRunning 
                      ? Colors.red 
                      : Theme.of(context).colorScheme.primary,
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  _isRunning ? Icons.stop : Icons.play_arrow,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: _isRunning ? _recordLap : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.flag, size: 30),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          const Divider(),
          
          // Laps list
          Expanded(
            child: _laps.isEmpty
                ? Center(
                    child: Text(
                      'No laps recorded',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _laps.length,
                    itemBuilder: (context, index) {
                      final lap = _laps[index];
                      final lapNumber = _laps.length - index;
                      
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text(
                            '$lapNumber',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          'Lap $lapNumber',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          _formatDuration(lap),
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'monospace',
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class StopwatchFacePainter extends CustomPainter {
  final int milliseconds;
  final Color color;

  StopwatchFacePainter({
    required this.milliseconds,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;
    final center = Offset(centerX, centerY);

    // Draw tick marks
    final tickMarkPaint = Paint()
      ..color = color
      ..strokeWidth = 2;

    // Draw 60 tick marks (one for each second/minute)
    for (int i = 0; i < 60; i++) {
      final angle = (i * 6) * (pi / 180);
      final outerX = centerX + (radius - 10) * sin(angle);
      final outerY = centerY - (radius - 10) * cos(angle);
      
      final isQuarterMark = i % 15 == 0;
      final isFiveMark = i % 5 == 0;
      
      final innerX = centerX + (radius - (isQuarterMark ? 25 : (isFiveMark ? 20 : 15))) * sin(angle);
      final innerY = centerY - (radius - (isQuarterMark ? 25 : (isFiveMark ? 20 : 15))) * cos(angle);

      final tickPaint = Paint()
        ..color = color
        ..strokeWidth = isQuarterMark ? 3 : (isFiveMark ? 2 : 1);

      canvas.drawLine(
        Offset(innerX, innerY),
        Offset(outerX, outerY),
        tickPaint,
      );
    }

    // Draw second hand
    final secondAngle = ((milliseconds / 1000) % 60) * 6 * (pi / 180);
    final secondHandLength = radius * 0.8;
    final secondHandX = centerX + secondHandLength * sin(secondAngle);
    final secondHandY = centerY - secondHandLength * cos(secondAngle);

    final secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondHandPaint);

    // Draw millisecond hand (makes 1 full rotation every second)
    final msAngle = ((milliseconds % 1000) / 1000) * 360 * (pi / 180);
    final msHandLength = radius * 0.6;
    final msHandX = centerX + msHandLength * sin(msAngle);
    final msHandY = centerY - msHandLength * cos(msAngle);

    final msHandPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, Offset(msHandX, msHandY), msHandPaint);
    
    // Draw minute hand (makes 1 full rotation every 30 minutes)
    final minuteAngle = ((milliseconds / 1000 / 60) % 30) * 12 * (pi / 180);
    final minuteHandLength = radius * 0.7;
    final minuteHandX = centerX + minuteHandLength * sin(minuteAngle);
    final minuteHandY = centerY - minuteHandLength * cos(minuteAngle);

    final minuteHandPaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minuteHandPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
