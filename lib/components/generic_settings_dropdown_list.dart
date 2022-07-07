import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/controls/dropdown_control.dart';
import 'package:frledger/controls/dropdown_list_content.dart';
import 'package:frledger/globals/styles.dart';

class GenericSettingsDropdownList extends StatelessWidget {
  const GenericSettingsDropdownList(
      {Key? key,
      this.onSelect,
      required this.x,
      required this.y,
      required this.height,
      required this.width,
      required this.icon,
      required this.control,
      required this.open,
      required this.close,
      required this.update})
      : super(key: key);

  final double x;
  final double y;
  final double width;
  final double height;
  final IconData icon;
  final DropdownCotrol control;
  final bool? Function(String value)? onSelect;

  final VoidCallback close;
  final VoidCallback open;
  final VoidCallback update;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: white, boxShadow: [slightElevatedOverOverlay]),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
                onTap: () {
                  close();
                },
                child: Row(
                  children: [
                    SizedBox(
                        width: height,
                        height: height,
                        child: Icon(icon,
                            color: paragraphColorDark, size: standardIconSize)),
                    Expanded(
                      child: DefaultText(
                        text: (control.values[control.selected] ??
                                const DropdownListContent(
                                    display: "", value: ""))
                            .display,
                      ),
                    ),
                    SizedBox(
                        width: height,
                        height: height,
                        child: const Icon(CarbonIcons.chevron_up,
                            color: paragraphColorDark, size: standardIconSize)),
                  ],
                )),
            const Divider(height: 1),
            for (String key in control.values.keys)
              GestureDetector(
                  onTap: () {
                    bool toClose = onSelect?.call(key) ?? true;
                    if (toClose) {
                      close();
                    }
                  },
                  child: Row(
                    children: [
                      SizedBox(
                          width: height,
                          height: height,
                          child: (control.values[key] ??
                                          const DropdownListContent(
                                              display: "", value: ""))
                                      .icon ==
                                  null
                              ? const SizedBox()
                              : Icon(
                                  (control.values[key] ??
                                          const DropdownListContent(
                                              display: "", value: ""))
                                      .icon,
                                  size: standardIconSize,
                                  color: paragraphColorDark,
                                )),
                      Expanded(
                        child: DefaultText(
                          text: (control.values[key] ??
                                  const DropdownListContent(
                                      display: "", value: ""))
                              .display,
                        ),
                      )
                    ],
                  ))
          ],
        ));
  }
}
