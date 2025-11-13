import 'package:flutter/material.dart';

import 'clock_widget.dart';
import 'weather_widget.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    this.cityName,
    this.textColor,
    this.dividerColor,
    this.showWeatherLoading = false,
  });

  final String? cityName;
  final Color? textColor;
  final Color? dividerColor;
  final bool showWeatherLoading;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = textColor ?? const Color(0xFF6B6B6B);
    final Color divColor = dividerColor ?? const Color(0xFF6B6B6B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClockWidget(width: 269, textColor: primaryColor),
        const SizedBox(width: 35),
        Container(width: 1, height: 71, color: divColor),
        const SizedBox(width: 35),
        WeatherWidget(
          cityName: cityName,
          textColor: primaryColor,
          showLoading: showWeatherLoading,
        ),
      ],
    );
  }
}

class ResponsiveInfoSection extends StatelessWidget {
  const ResponsiveInfoSection({
    super.key,
    this.cityName,
    this.textColor,
    this.mobileBreakpoint = 600,
  });

  final String? cityName;
  final Color? textColor;
  final double mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < mobileBreakpoint;
        if (isMobile) {
          return _buildVerticalLayout();
        }
        return InfoSection(
          cityName: cityName,
          textColor: textColor,
          showWeatherLoading: true,
        );
      },
    );
  }

  Widget _buildVerticalLayout() {
    final Color primaryColor = textColor ?? const Color(0xFF6B6B6B);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClockWidget(width: 200, textColor: primaryColor),
        const SizedBox(height: 20),
        Container(width: 71, height: 1, color: primaryColor),
        const SizedBox(height: 20),
        WeatherWidget(
          cityName: cityName,
          textColor: primaryColor,
          showLoading: true,
        ),
      ],
    );
  }
}
