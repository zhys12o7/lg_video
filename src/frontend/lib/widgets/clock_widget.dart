import 'package:flutter/material.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({
    super.key,
    required this.width,
    this.textColor,
  });

  final double width;
  final Color? textColor;

  String _formatTime(DateTime time) {
    final int hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final String minute = time.minute.toString().padLeft(2, '0');
    final String period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _formatDate(DateTime time) {
    const List<String> weekdays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];
    final String weekday = weekdays[time.weekday % 7];
    return '$weekday ${time.year}.${time.month.toString().padLeft(2, '0')}.${time.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final Color color = textColor ?? const Color(0xFF6B6B6B);

    return SizedBox(
      width: width,
      child: StreamBuilder<DateTime>(
        stream: Stream<DateTime>.periodic(
          const Duration(seconds: 1),
          (_) => DateTime.now(),
        ),
        builder: (context, snapshot) {
          final DateTime now = snapshot.data ?? DateTime.now();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatTime(now),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ) ??
                    TextStyle(
                      color: color,
                      fontSize: 46,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                _formatDate(now),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: color,
                    ) ??
                    TextStyle(
                      color: color,
                      fontSize: 18,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
