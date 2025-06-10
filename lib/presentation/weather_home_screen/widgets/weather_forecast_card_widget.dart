import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_view.dart';

class WeatherForecastCardWidget extends StatelessWidget {
  final String time;
  final String? precipitation;
  final String iconPath;
  final String temperature;
  final bool showPrecipitation;

  WeatherForecastCardWidget({
    Key? key,
    required this.time,
    this.precipitation,
    required this.iconPath,
    required this.temperature,
    required this.showPrecipitation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.h,
      decoration: BoxDecoration(
        color: appTheme.colorFF4831,
        borderRadius: BorderRadius.circular(24.h),
        border: Border.all(
          color: appTheme.whiteCustom.withAlpha(51),
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.blackCustom.withAlpha(51),
            blurRadius: 8.h,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: TextStyleHelper.instance.body14SemiBold,
          ),
          SizedBox(height: 8.h),
          if (showPrecipitation && precipitation != null) ...[
            Text(
              precipitation!,
              style: TextStyleHelper.instance.body12SemiBold,
            ),
            SizedBox(height: 8.h),
          ] else if (!showPrecipitation) ...[
            SizedBox(height: 24.h),
          ],
          CustomImageView(
            imagePath: iconPath,
            width: 32.h,
            height: 32.h,
          ),
          SizedBox(height: 8.h),
          Text(
            temperature,
            style: TextStyleHelper.instance.title18Regular,
          ),
        ],
      ),
    );
  }
}
