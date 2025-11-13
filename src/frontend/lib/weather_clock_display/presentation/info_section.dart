import 'package:flutter/material.dart';
import 'clock_widget.dart';
import 'weather_widget.dart';

/// 통합 위젯 (디자인 명세서 버전)
///
/// 디자인 명세:
/// - 레이아웃: Horizontal Flexbox, items-center, justify-center
/// - 간격: gap 35px
/// - 구성: 시간 (269px) | 구분선 (71px × 1px) | 날씨
/// - 구분선: #6B6B6B, 세로 실선
class InfoSection extends StatelessWidget {
  final String? cityName;
  final Color? textColor;
  final Color? dividerColor;
  final bool showWeatherLoading;

  const InfoSection({
    super.key,
    this.cityName,
    this.textColor,
    this.dividerColor,
    this.showWeatherLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = textColor ?? const Color(0xFF6B6B6B);
    final divColor = dividerColor ?? const Color(0xFF6B6B6B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 269,
          height: 90,
          child: Align(
            alignment: Alignment.centerRight,
            child: ClockWidget(
              width: 269,
              height: 90,
              textColor: primaryColor,
              fontSize: 72,
              amPmFontSize: 36,
              verticalOffset: -6,
            ),
          ),
        ),
        const SizedBox(width: 35),
        Container(width: 1, height: 90, color: divColor),
        const SizedBox(width: 35),
        Flexible(
          child: SizedBox(
            height: 90,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                offset: const Offset(-35, 0),
                child: WeatherWidget(
                  cityName: cityName,
                  textColor: primaryColor,
                  showLoading: showWeatherLoading,
                  iconSize: 50,
                  temperatureFontSize: 72,
                  unitFontSize: 65,
                  conditionFontSize: 18,
                  showCondition: false,
                  height: 90,
                  textVerticalOffset: -6,
                iconVerticalOffset: -4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 반응형 통합 위젯
///
/// 모바일: 세로 레이아웃
/// 데스크톱: 가로 레이아웃
class ResponsiveInfoSection extends StatelessWidget {
  final String? cityName;
  final Color? textColor;
  final double mobileBreakpoint;

  const ResponsiveInfoSection({
    super.key,
    this.cityName,
    this.textColor,
    this.mobileBreakpoint = 600,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < mobileBreakpoint;

        if (isMobile) {
          // 모바일: 컴팩트 가로 레이아웃
          return _buildCompactHorizontalLayout();
        }

        // 데스크톱: 기본 가로 레이아웃
        return InfoSection(
          cityName: cityName,
          textColor: textColor,
          showWeatherLoading: true,
        );
      },
    );
  }

  Widget _buildCompactHorizontalLayout() {
    final primaryColor = textColor ?? const Color(0xFF6B6B6B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          child: SizedBox(
            height: 56,
            child: Align(
              alignment: Alignment.centerRight,
              child: ClockWidget(
                width: 200,
                textColor: primaryColor,
                fontSize: 32,
                amPmFontSize: 20,
                height: 56,
                verticalOffset: -4,
              ),
            ),
          ),
        ),

        const SizedBox(width: 20),

        Container(width: 1, height: 64, color: primaryColor),

        const SizedBox(width: 20),

        Flexible(
          flex: 6,
          child: SizedBox(
            height: 64,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                offset: const Offset(-35, 0),
                child: WeatherWidget(
                  cityName: cityName,
                  textColor: primaryColor,
                  showLoading: true,
                  iconSize: 36,
                  temperatureFontSize: 36,
                  unitFontSize: 20,
                  conditionFontSize: 14,
                  showCondition: false,
                  height: 64,
                  textVerticalOffset: -4,
                iconVerticalOffset: -3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
