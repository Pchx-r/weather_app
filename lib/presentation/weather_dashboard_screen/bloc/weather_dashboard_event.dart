part of 'weather_dashboard_bloc.dart';

abstract class WeatherDashboardEvent extends Equatable {
  const WeatherDashboardEvent();

  @override
  List<Object?> get props => [];
}

class WeatherDashboardInitialEvent extends WeatherDashboardEvent {}

class SearchTextChangedEvent extends WeatherDashboardEvent {
  final String searchText;

  const SearchTextChangedEvent(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

class WeatherCardTappedEvent extends WeatherDashboardEvent {
  final WeatherCardModel weatherCard;

  const WeatherCardTappedEvent(this.weatherCard);

  @override
  List<Object?> get props => [weatherCard];
}
