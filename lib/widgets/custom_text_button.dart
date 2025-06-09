import 'package:flutter/material.dart';

import '../core/app_export.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.isEnabled,
  }) : super(key: key);

  /// The text to display on the button
  final String text;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Color of the button text
  final Color? textColor;

  /// Size of the button text
  final double? fontSize;

  /// Weight of the button text
  final FontWeight? fontWeight;

  /// Whether the button is enabled or disabled
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    final bool buttonEnabled = isEnabled ?? true;

    return TextButton(
      onPressed: buttonEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 8.h,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: TextStyleHelper.instance.textStyle8
            .copyWith(color: textColor ?? appTheme.grey400),
      ),
    );
  }
}
