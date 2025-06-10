import 'package:flutter/material.dart';
import 'package:weather_app/presentation/weather_dashboard_screen/weather_dashboard_screen.dart';
import '../presentation/weather_home_screen/weather_home_screen.dart';


class AppRoutes {
  static const String weatherHomeScreen = '/weather_home_screen';

  static const String weatherDashboardScreen = '/weather_dashboard_screen';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        weatherHomeScreen: (context) => WeatherHomeScreen(),
        weatherDashboardScreen: WeatherDashboardScreen.builder
      };
}
