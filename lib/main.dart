import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/presentation/weather_home_screen/weather_home_screen.dart';

import 'core/app_export.dart';


void main() => runApp(const MyApp());
  

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ValueNotifier(0),
      builder: (context, value, widget){
        return MaterialApp(
          home:   WeatherHomeScreen(),
          routes: AppRoutes.routes,

        );
      }
    );
  }
}