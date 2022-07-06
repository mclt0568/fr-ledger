import 'package:flutter/widgets.dart';

class DropdownListContent {
  const DropdownListContent(
      {required this.display, this.icon, required this.value});

  final IconData? icon;
  final String value;
  final String display;
}
