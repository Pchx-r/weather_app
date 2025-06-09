import '../../../core/app_export.dart';
import 'weather_card_model.dart';

class WeatherDashboardModel extends Equatable {
  List<WeatherCardModel>? weatherCards;

  WeatherDashboardModel({
    this.weatherCards,
  }) {
    weatherCards = weatherCards ?? [];
  }

  WeatherDashboardModel copyWith({
    List<WeatherCardModel>? weatherCards,
  }) {
    return WeatherDashboardModel(
      weatherCards: weatherCards ?? this.weatherCards,
    );
  }

  @override
  List<Object?> get props => [weatherCards];
}
