import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    this.cityName,
    this.textColor,
    this.showLoading = false,
  });

  final String? cityName;
  final Color? textColor;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    final Color color = textColor ?? const Color(0xFF6B6B6B);

    return SizedBox(
      width: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: showLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Loading...',
                      style: TextStyle(color: color),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_rounded, color: color, size: 32),
                    const SizedBox(height: 12),
                    Text(
                      cityName ?? 'Seoul',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '24°C • Clear',
                      style: TextStyle(color: color.withOpacity(0.8)),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
