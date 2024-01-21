import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  withCenter() => Center(
        child: this,
      );
}

extension VerticalSpace on int {
  vertical() => SizedBox(
        height: this + 0.0,
      );
}

extension HorizontalSpace on int {
  horizontal() => SizedBox(
        width: this + 0.0,
      );
}
