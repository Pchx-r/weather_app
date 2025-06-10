import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_view.dart';
import '../models/weather_card_model.dart';

class WeatherCardWidget extends StatelessWidget {
  final WeatherCardModel weatherCard;
  final VoidCallback? onTap;

  const WeatherCardWidget({
    Key? key,
    required this.weatherCard,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 342.h,
        height: 184.h,
        child: Stack(
          children: [
            CustomImageView(
              imagePath: weatherCard.backgroundImage ?? '',
              width: 342.h,
              height: 184.h,
              fit: BoxFit.cover,
            ),
            Container(
              width: 342.h,
              height: 184.h,
              padding: EdgeInsets.all(20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLeftSection(),
                  _buildRightSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weatherCard.temperature ?? '',
            style: TextStyleHelper.instance.display52.copyWith(height: 1.20),
          ),
          SizedBox(height: 16.h),
          Text(
            '${weatherCard.highTemp ?? ''} ${weatherCard.lowTemp ?? ''}',
            style: TextStyleHelper.instance.body13.copyWith(height: 1.38),
          ),
          SizedBox(height: 4.h),
          Text(
            weatherCard.location ?? '',
            style: TextStyleHelper.instance.title17
                .copyWith(color: appTheme.whiteCustom, height: 1.29),
          ),
        ],
      ),
    );
  }

  Widget _buildRightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomImageView(
          imagePath: weatherCard.weatherIcon ?? '',
          width: 140.h,
          height: 110.h,
        ),
        SizedBox(height: 8.h),
        Text(
          weatherCard.weatherDescription ?? '',
          style: TextStyleHelper.instance.body13
              .copyWith(color: appTheme.whiteCustom, height: 1.23),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
