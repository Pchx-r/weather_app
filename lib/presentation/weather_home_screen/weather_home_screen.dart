import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/app_export.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_button.dart';
import './widgets/weather_forecast_card_widget.dart';

class WeatherHomeScreen extends StatefulWidget {
  @override
  _WeatherHomeScreenState createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  List<Map<String, dynamic>> forecastData = [];
  String currentTemp = '--';
  String weatherCondition = '--';
  String maxTemp = '--';
  String minTemp = '--';

  @override
  void initState() {
    super.initState();
    loadWeatherData();
  }

  Future<void> loadWeatherData() async {
  final url = Uri.parse(
    'https://api.weatherapi.com/v1/forecast.json?key=d404c7ea36ea4ee4b0b01326250706&q=Celaya&days=1&aqi=no&alerts=no');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final current = data['current'];
    final forecastDay = data['forecast']['forecastday'][0]['day'];
    final hours = data['forecast']['forecastday'][0]['hour'] as List;

    setState(() {
      currentTemp = '${current['temp_c'].toStringAsFixed(1)}°';
      weatherCondition = current['condition']['text'];
      maxTemp = '${forecastDay['maxtemp_c'].toStringAsFixed(1)}°';
      minTemp = '${forecastDay['mintemp_c'].toStringAsFixed(1)}°';

      forecastData = hours.map((h) {
        return {
          'time': h['time'].substring(11, 16),
          'precipitation': h['precip_mm'] != null && h['precip_mm'] > 0
              ? '${h['precip_mm']} mm'
              : null,
          'icon': getWeatherIcon(h['condition']['text']),
          'temperature': '${h['temp_c'].toStringAsFixed(1)}°',
          'showPrecipitation': h['precip_mm'] != null && h['precip_mm'] > 0,
        };
      }).toList();
    });
  } else {
    throw Exception('Failed to load weather data');
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGradientBackground(),
          _buildBackgroundElements(),
          _buildMainContent(context),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.8, -0.6),
          end: Alignment(-0.8, 1.0),
          colors: [
            Color(0xFF2E335A),
            appTheme.colorFF1C1B,
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: 32.h,
          left: 0,
          child: Opacity(
            opacity: 0.8,
            child: Container(
              width: 352.h,
              height: 352.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF612FAB),
                    appTheme.colorFF612E,
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: CustomImageView(
            imagePath: ImageConstant.imgBackground,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 320.h,
          left: 0,
          right: 0,
          child: Center(
            child: CustomImageView(
              imagePath: ImageConstant.imgHouse43,
              width: 384.h,
              height: 384.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          bottom: 80.h,
          left: 24.h,
          child: Opacity(
            opacity: 0.0,
            child: CustomImageView(
              imagePath: ImageConstant.imgUvIndex,
              width: 160.h,
              height: 160.h,
            ),
          ),
        ),
        Positioned(
          bottom: 80.h,
          right: 24.h,
          child: Opacity(
            opacity: 0.0,
            child: CustomImageView(
              imagePath: ImageConstant.imgSunrise,
              width: 160.h,
              height: 160.h,
            ),
          ),
        ),
        Positioned(
          bottom: 160.h,
          left: 24.h,
          child: Opacity(
            opacity: 0.0,
            child: CustomImageView(
              imagePath: ImageConstant.imgWidgets,
              width: 168.h,
              height: 160.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        _buildWeatherInfo(),
        Spacer(),
        _buildForecastBottomSheet(context),
      ],
    );
  }

  Widget _buildWeatherInfo() {
    return Container(
      padding: EdgeInsets.only(
        top: 48.h,
        left: 32.h,
        right: 32.h,
      ),
      child: Column(
        children: [
          Text(
            'Celaya',
            style: TextStyleHelper.instance.headline24Regular,
          ),
          SizedBox(height: 8.h),
          Text(
            currentTemp,
            style: TextStyleHelper.instance.display64Thin,
          ),
          SizedBox(height: 16.h),
          Column(
            children: [
              Text(
                weatherCondition,
                style: TextStyleHelper.instance.title16SemiBold,
              ),
              SizedBox(height: 4.h),
              Text(
                'H:$maxTemp   L:$minTemp',
                style: TextStyleHelper.instance.title16SemiBold
                    .copyWith(color: appTheme.whiteCustom),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForecastBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.h),
          topRight: Radius.circular(24.h),
        ),
        gradient: LinearGradient(
          begin: Alignment(0.8, -0.6),
          end: Alignment(-0.8, 1.0),
          colors: [
            Color(0xFF2E335A),
            appTheme.colorFF1C1B,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.blackCustom.withAlpha(77),
            blurRadius: 16.h,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildForecastHeader(),
          _buildDivider(),
          _buildHandleBar(),
          _buildHourlyForecast(),
          _buildBottomNavigation(context),
        ],
      ),
    );
  }

  Widget _buildForecastHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(
            text: 'Hourly Forecast',
            textColor: appTheme.colorFF9CA3,
            fontSize: 14.fSize,
            fontWeight: FontWeight.w600,
          ),
          CustomTextButton(
            text: 'Weekly Forecast',
            textColor: appTheme.colorFF9CA3,
            fontSize: 14.fSize,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1.h,
      color: appTheme.whiteCustom.withAlpha(51),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      margin: EdgeInsets.only(top: 16.h, bottom: 24.h),
      width: 48.h,
      height: 4.h,
      decoration: BoxDecoration(
        color: appTheme.colorFF4B55,
        borderRadius: BorderRadius.circular(2.h),
      ),
    );
  }

  Widget _buildHourlyForecast() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      margin: EdgeInsets.only(bottom: 24.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            forecastData.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                right: index < forecastData.length - 1 ? 16.h : 0,
              ),
              child: WeatherForecastCardWidget(
                time: forecastData[index]['time'] ?? '',
                precipitation: forecastData[index]['precipitation'],
                iconPath: forecastData[index]['icon'] ?? '',
                temperature: forecastData[index]['temperature'] ?? '',
                showPrecipitation:
                    forecastData[index]['showPrecipitation'] ?? false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(ImageConstant.imgSymbol, context, ''),
          _buildFloatingActionButton(),
          _buildIconButton(ImageConstant.imgSymbol31x24, context, AppRoutes.weatherDashboardScreen),
        ],
      ),
    );
  }

  Widget _buildIconButton(String iconPath, BuildContext context, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: 48.h,
        height: 48.h,
        child: Center(
          child: CustomImageView(
            imagePath: iconPath,
            width: 24.h,
            height: 24.h,
          ),
        ),
      ),
    );
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


  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(-0.8, -0.6),
          end: Alignment(0.8, 0.6),
          colors: [
            Color(0x3F000000),
            appTheme.whiteCustom,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.blackCustom.withAlpha(51),
            blurRadius: 8.h,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.h),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(-0.6, -0.8),
            end: Alignment(0.6, 0.8),
            colors: [
              Color(0xFFF5F5F9),
              appTheme.colorFFDADF,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: appTheme.blackCustom.withAlpha(26),
              blurRadius: 4.h,
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        padding: EdgeInsets.all(4.h),
        child: Container(
          width: 56.h,
          height: 56.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment(-0.4, -0.8),
              end: Alignment(0.4, 0.8),
              colors: [
                appTheme.whiteCustom,
                appTheme.colorFFBBBF,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: appTheme.blackCustom.withAlpha(26),
                blurRadius: 6.h,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Center(
            child: CustomImageView(
              imagePath: ImageConstant.imgSymbol40x27,
              width: 40.h,
              height: 27.h,
            ),
          ),
        ),
      ),
    );
  }
}

class HourlyWeather {
  final String time;
  final String condition;
  final double tempC;
  final String? precipitation;

  HourlyWeather({
    required this.time,
    required this.condition,
    required this.tempC,
    this.precipitation,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: json['time'].substring(11, 16), 
      condition: json['condition']['text'],
      tempC: json['temp_c'],
      precipitation: json['chance_of_rain'] != null
          ? '${json['chance_of_rain']}%'
          : null,
    );
  }
}

Future<List<HourlyWeather>> fetchHourlyForecast() async {
  final url = Uri.parse('https://api.weatherapi.com/v1/forecast.json?key=d404c7ea36ea4ee4b0b01326250706&q=Celaya&days=1&aqi=no&alerts=no');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final hours = data['forecast']['forecastday'][0]['hour'] as List;
    return hours.map((h) => HourlyWeather.fromJson(h)).toList();
  } else {
    throw Exception('Failed to load hourly forecast');
  }
}
