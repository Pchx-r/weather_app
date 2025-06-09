import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/app_export.dart';
import '../models/weather_card_model.dart';
import '../models/weather_dashboard_model.dart';

part 'weather_dashboard_event.dart';
part 'weather_dashboard_state.dart';

class WeatherDashboardBloc
    extends Bloc<WeatherDashboardEvent, WeatherDashboardState> {
  WeatherDashboardBloc(WeatherDashboardState initialState)
      : super(initialState) {
    on<WeatherDashboardInitialEvent>(_onInitialize);
    on<SearchTextChangedEvent>(_onSearchTextChanged);
    on<WeatherCardTappedEvent>(_onWeatherCardTapped);
  }

  Future<Map<String, dynamic>> fetchWeatherData() async {
    final url = Uri.parse('https://api.weatherapi.com/v1/forecast.json?key=d404c7ea36ea4ee4b0b01326250706&q=Celaya&days=7&aqi=no&alerts=no');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }


  _onInitialize(
  WeatherDashboardInitialEvent event,
  Emitter<WeatherDashboardState> emit,
) async {
  emit(state.copyWith(searchController: TextEditingController()));

  try {
    final data = await fetchWeatherData();
    final weather = WeatherApiModel.fromJson(data);

    List<WeatherCardModel> weatherCards = weather.forecast.map((day) {
      return WeatherCardModel(
        temperature: '${day.avgTempC.toStringAsFixed(1)}°',
        highTemp: 'H:${day.maxTempC.toStringAsFixed(1)}°',
        lowTemp: 'L:${day.minTempC.toStringAsFixed(1)}°',
        location: weather.location,
        weatherIcon: getWeatherIcon(day.condition),
        weatherDescription: day.condition,
        backgroundImage: ImageConstant.imgRectangle1,
      );
    }).toList();

    emit(state.copyWith(
      weatherDashboardModel: state.weatherDashboardModel?.copyWith(
        weatherCards: weatherCards,
      ),
    ));
  } catch (e) {
    print('Error fetching weather: $e');
  }
}


  _onSearchTextChanged(
    SearchTextChangedEvent event,
    Emitter<WeatherDashboardState> emit,
  ) async {
    emit(state.copyWith(
      searchText: event.searchText,
    ));
  }

  _onWeatherCardTapped(
    WeatherCardTappedEvent event,
    Emitter<WeatherDashboardState> emit,
  ) async {
    emit(state.copyWith(
      selectedWeatherCard: event.weatherCard,
    ));
  }
}

class WeatherApiModel {
  final String location;
  final List<DailyForecast> forecast;

  WeatherApiModel({
    required this.location,
    required this.forecast,
  });

  factory WeatherApiModel.fromJson(Map<String, dynamic> json) {
    return WeatherApiModel(
      location: json['location']['name'],
      forecast: (json['forecast']['forecastday'] as List)
          .map((day) => DailyForecast.fromJson(day))
          .toList(),
    );
  }
}

class DailyForecast {
  final String date;
  final double maxTempC;
  final double minTempC;
  final double avgTempC;
  final String condition;

  DailyForecast({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.condition,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json['date'],
      maxTempC: json['day']['maxtemp_c'],
      minTempC: json['day']['mintemp_c'],
      avgTempC: json['day']['avgtemp_c'],
      condition: json['day']['condition']['text'],
    );
  }
}


String getWeatherIcon(String condition) {
  switch (condition) {
    case 'Patchy rain nearby':
      return ImageConstant.imgSunCloudAngledRain;
    case 'clear':
      return ImageConstant.imgSunny;
    case 'rain':
    case 'Light Rain':
      return ImageConstant.imgMoonCloudMidRain;
    case 'Tornado':
      return ImageConstant.imgTornado;
    case 'Sunny':
      return ImageConstant.imgSunny;
    case 'Moderate rain':
      return ImageConstant.imgSunCloudMidRain;
    default:
      return ImageConstant.imgCloudy;
  }
}
