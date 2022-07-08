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
    double screenHeight = MediaQuery.of(context).size.height;
    double systemTopPadding = MediaQuery.of(context).padding.top;

    double calculatedY = 0;
    double calculatedHeight = 0;

    double fullHeight = (height * control.values.length) + height + 1;

    double startOfButton = y;
    double endOfButton = y + height;

    double topAvailable = endOfButton - (pagePadding + systemTopPadding);
    double bottomAvailable = screenHeight - (startOfButton + pagePadding);

    bool alternativeRender = topAvailable > bottomAvailable;

    double actualAvailable = alternativeRender ? topAvailable : bottomAvailable;

    bool fullHeightAllowed = fullHeight < actualAvailable;

    calculatedHeight = fullHeightAllowed ? fullHeight : actualAvailable;

    if (alternativeRender) {
      calculatedY = endOfButton - calculatedHeight;
    } else {
      calculatedY = y;
    }

    return Container(
      decoration: const BoxDecoration(
          color: white, boxShadow: [slightElevatedOverOverlay]),
      width: width,
      constraints: BoxConstraints(maxHeight: calculatedHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GenericSettingsDropdownListMainItem(
            close: close,
            height: height,
            icon: icon,
            control: control,
            alternativeRender: alternativeRender,
          ),
          const Divider(height: 1),
          GenericSettingsDropdownListItemSelect(
              calculatedHeight: calculatedHeight,
              height: height,
              control: control,
              onSelect: onSelect,
              close: close),
        ],
      ),
    );
  }
}

class GenericSettingsDropdownListItemSelect extends StatelessWidget {
  const GenericSettingsDropdownListItemSelect({
    Key? key,
    required this.calculatedHeight,
    required this.height,
    required this.control,
    required this.onSelect,
    required this.close,
  }) : super(key: key);

  final double calculatedHeight;
  final double height;
  final DropdownCotrol control;
  final bool? Function(String value)? onSelect;
  final VoidCallback close;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: grayBackground,
      constraints: BoxConstraints(maxHeight: calculatedHeight - height - 1),
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                for (String key in control.values.keys)
                  GestureDetector(
                    onTap: () {
                      control.selected = key;
                      bool toClose = onSelect?.call(key) ?? true;
                      if (toClose) {
                        close();
                      }
                    },
                    child: SizedBox(
                      height: height,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: white,
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
                                  ),
                          ),
                          Expanded(
                            child: Container(
                              color: white,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: DefaultText(
                                  text: (control.values[key] ??
                                          const DropdownListContent(
                                              display: "", value: ""))
                                      .display,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenericSettingsDropdownListMainItem extends StatelessWidget {
  const GenericSettingsDropdownListMainItem({
    Key? key,
    required this.close,
    required this.height,
    required this.icon,
    required this.control,
    required this.alternativeRender,
  }) : super(key: key);

  final VoidCallback close;
  final double height;
  final IconData icon;
  final DropdownCotrol control;
  final bool alternativeRender;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      const DropdownListContent(display: "", value: ""))
                  .display,
            ),
          ),
          SizedBox(
            width: height,
            height: height,
            child: Icon(
              alternativeRender
                  ? CarbonIcons.chevron_down
                  : CarbonIcons.chevron_up,
              color: paragraphColorDark,
              size: standardIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
