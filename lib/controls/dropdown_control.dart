import 'package:flutter/widgets.dart';
import 'package:frledger/controls/dropdown_list_content.dart';

class DropdownCotrol {
  DropdownCotrol(
      {this.selected,
      required this.values,
      required this.key,
      required this.dropdownListBuilder});

  final String key;
  final Widget Function(
    double x,
    double y,
    double width,
    double height,
    DropdownCotrol control,
    VoidCallback open,
    VoidCallback close,
    VoidCallback update,
  ) dropdownListBuilder;
  final Map<String, DropdownListContent> values;
  String? selected = "";

  String getTruKeyString() {
    return "_dropdown_$key";
  }
}
