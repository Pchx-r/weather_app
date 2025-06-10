import 'package:flutter/material.dart';
import 'package:weather_app/presentation/weather_home_screen/weather_home_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_image_view.dart';
import 'bloc/weather_dashboard_bloc.dart';
import 'models/weather_dashboard_model.dart';
import 'widgets/weather_card_widget.dart';

class WeatherDashboardScreen extends StatelessWidget {
  const WeatherDashboardScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<WeatherDashboardBloc>(
      create: (context) => WeatherDashboardBloc(WeatherDashboardState(
        weatherDashboardModel: WeatherDashboardModel(),
      ))
        ..add(WeatherDashboardInitialEvent()),
      child: const WeatherDashboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherDashboardBloc, WeatherDashboardState>(
        builder: (context, state) {
          return Stack(
            children: [
              _buildGradientBackground(),
              _buildBackgroundElements(),
              _buildMainContent(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
          top: 72.h,
          left: 5.h,
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
                  appTheme.colorFF612F,
                  appTheme.colorFF612E,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: appTheme.colorFF8888,
                  blurRadius: 196.h,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 462.h,
          left: 130.h,
          child: CustomImageView(
            imagePath: ImageConstant.imgEllipse817,
            width: 259.h,
            height: 365.h,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context, WeatherDashboardState state) {
    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: _buildWeatherCardsList(context, state),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 87.h,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.weatherHomeScreen);
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgIconChevronleft,
              width: 14.h,
              height: 32.h,
            ),
          ),
          SizedBox(width: 24.h),
          Text(
            'Weather',
            style: TextStyleHelper.instance.headline28.copyWith(height: 1.21),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgRightTitle,
            width: 33.h,
            height: 34.h,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, WeatherDashboardState state) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.h, 11.h, 16.h, 16.h),
      child: Container(
        height: 36.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E335A),
              appTheme.colorFF1C1B,
            ],
          ),
          borderRadius: BorderRadius.circular(10.h),
          boxShadow: [
            BoxShadow(
              color: appTheme.blackCustom.withAlpha(64),
              blurRadius: 4.h,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 8.h),
            CustomImageView(
              imagePath: ImageConstant.imgIconMagnifyingglass,
              width: 15.h,
              height: 15.h,
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: TextFormField(
                controller: state.searchController,
                style: TextStyleHelper.instance.title17.copyWith(height: 1.24),
                decoration: InputDecoration(
                  hintText: 'Search for a city or airport',
                  hintStyle:
                      TextStyleHelper.instance.title17.copyWith(height: 1.24),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  context.read<WeatherDashboardBloc>().add(
                        SearchTextChangedEvent(value),
                      );
                },
              ),
            ),
            SizedBox(width: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCardsList(
      BuildContext context, WeatherDashboardState state) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(24.h, 0, 24.h, 80.h),
      itemCount: state.weatherDashboardModel?.weatherCards?.length ?? 0,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final weatherCard = state.weatherDashboardModel?.weatherCards?[index];
        if (weatherCard == null) return SizedBox.shrink();

        return WeatherCardWidget(
          weatherCard: weatherCard,
          onTap: () {
            context.read<WeatherDashboardBloc>().add(
                  WeatherCardTappedEvent(weatherCard),
                );
          },
        );
      },
    );
  }
}
