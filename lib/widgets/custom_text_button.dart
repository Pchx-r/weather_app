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

  final String text;

  final VoidCallback? onPressed;

  final Color? textColor;

  final double? fontSize;

  final FontWeight? fontWeight;

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
