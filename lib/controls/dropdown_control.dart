import 'package:flutter/widgets.dart';

class DropdownCotrol {
  DropdownCotrol(
      {this.selected, required this.key, required this.dropdownListBuilder});

  final String key;
  final Widget Function(double x, double y, double width, double height)
      dropdownListBuilder;
  String? selected = "";

  String getTruKeyString() {
    return "_dropdown_$key";
  }
}
