import 'package:flutter/cupertino.dart';

extension WidgetExtensions on int {
  Widget get height => SizedBox(height: double.parse(toString()));
  Widget get width => SizedBox(width: double.parse(toString()));
}