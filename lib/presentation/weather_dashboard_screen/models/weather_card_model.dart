import '../../../core/app_export.dart';

class WeatherCardModel extends Equatable {
  String? temperature;
  String? highTemp;
  String? lowTemp;
  String? location;
  String? weatherIcon;
  String? weatherDescription;
  String? backgroundImage;

  WeatherCardModel({
    this.temperature,
    this.highTemp,
    this.lowTemp,
    this.location,
    this.weatherIcon,
    this.weatherDescription,
    this.backgroundImage,
  }) {
    temperature = temperature ?? '';
    highTemp = highTemp ?? '';
    lowTemp = lowTemp ?? '';
    location = location ?? '';
    weatherIcon = weatherIcon ?? '';
    weatherDescription = weatherDescription ?? '';
    backgroundImage = backgroundImage ?? '';
  }

  WeatherCardModel copyWith({
    String? temperature,
    String? highTemp,
    String? lowTemp,
    String? location,
    String? weatherIcon,
    String? weatherDescription,
    String? backgroundImage,
  }) {
    return WeatherCardModel(
      temperature: temperature ?? this.temperature,
      highTemp: highTemp ?? this.highTemp,
      lowTemp: lowTemp ?? this.lowTemp,
      location: location ?? this.location,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  @override
  List<Object?> get props => [
        temperature,
        highTemp,
        lowTemp,
        location,
        weatherIcon,
        weatherDescription,
        backgroundImage,
      ];
}
