part of 'weather_dashboard_bloc.dart';

class WeatherDashboardState extends Equatable {
  final TextEditingController? searchController;
  final String? searchText;
  final WeatherDashboardModel? weatherDashboardModel;
  final WeatherCardModel? selectedWeatherCard;
  final bool isLoading;

  const WeatherDashboardState({
    this.searchController,
    this.searchText,
    this.weatherDashboardModel,
    this.selectedWeatherCard,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        searchController,
        searchText,
        weatherDashboardModel,
        selectedWeatherCard,
        isLoading,
      ];

  WeatherDashboardState copyWith({
    TextEditingController? searchController,
    String? searchText,
    WeatherDashboardModel? weatherDashboardModel,
    WeatherCardModel? selectedWeatherCard,
    bool? isLoading,
  }) {
    return WeatherDashboardState(
      searchController: searchController ?? this.searchController,
      searchText: searchText ?? this.searchText,
      weatherDashboardModel:
          weatherDashboardModel ?? this.weatherDashboardModel,
      selectedWeatherCard: selectedWeatherCard ?? this.selectedWeatherCard,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
