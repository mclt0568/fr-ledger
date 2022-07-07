import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/components/generic_settings_dropdown_list.dart';
import 'package:frledger/components/horizontal_dropdown.dart';
import 'package:frledger/components/settings_group.dart';
import 'package:frledger/controls/dropdown_control.dart';
import 'package:frledger/controls/dropdown_list_content.dart';
import 'package:frledger/globals/internationalization.dart';
import 'package:frledger/globals/styles.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sprintf/sprintf.dart';

class DebugSubpage extends StatefulWidget {
  const DebugSubpage({Key? key}) : super(key: key);

  @override
  State<DebugSubpage> createState() => _DebugSubpageState();
}

class _DebugSubpageState extends State<DebugSubpage> {
  Map text = {};
  String version = "";
  String currentLanguage = "";

  Future<void> getData() async {
    var result = await Internationalization.getTranslationObject(
        context, "ledger_list_page");
    var currentLang = await Internationalization.getLanguage();
    setState(() {
      text = result;
      currentLanguage = currentLang;
    });

    //get version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  String getText(String key) {
    if (text == {}) return "";
    return text[key].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: headerPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DefaultText(
                    text: getText("debug"),
                    size: headerFontSize,
                    color: headerColor),
                DefaultText(
                    text: sprintf(getText("frledger"), [version]),
                    size: subheaderFontSize,
                    color: paragraphColorDark),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SettingsGroup(
                      title: "Test Settings Group",
                      children: [
                        HorizontalDropdown(
                          icon: CarbonIcons.debug,
                          text: "Debug",
                          control: DropdownCotrol(
                            values: {
                              "a": const DropdownListContent(
                                  display: "A", value: "a"),
                              "b": const DropdownListContent(
                                  display: "B", value: "b"),
                              "c": const DropdownListContent(
                                  display: "C", value: "c"),
                              "d": const DropdownListContent(
                                  display: "D", value: "d"),
                              "e": const DropdownListContent(
                                  display: "E", value: "e"),
                              "f": const DropdownListContent(
                                  display: "F", value: "f"),
                              "g": const DropdownListContent(
                                  display: "G", value: "g"),
                              "h": const DropdownListContent(
                                  display: "H", value: "h"),
                              "i": const DropdownListContent(
                                  display: "I", value: "i"),
                              "j": const DropdownListContent(
                                  display: "J", value: "j"),
                            },
                            selected: "a",
                            key: "debug",
                            dropdownListBuilder: (
                              double x,
                              double y,
                              double width,
                              double height,
                              DropdownCotrol control,
                              VoidCallback open,
                              VoidCallback close,
                              VoidCallback update,
                            ) =>
                                GenericSettingsDropdownList(
                              x: x,
                              y: y,
                              height: height,
                              width: width,
                              icon: CarbonIcons.debug,
                              control: control,
                              open: open,
                              close: close,
                              update: update,
                            ),
                          ),
                        ),
                        HorizontalDropdown(
                          icon: CarbonIcons.debug,
                          text: "Debug",
                          control: DropdownCotrol(
                            values: {
                              "a": const DropdownListContent(
                                  display: "A", value: "a"),
                              "b": const DropdownListContent(
                                  display: "B", value: "b"),
                              "c": const DropdownListContent(
                                  display: "C", value: "c"),
                              "d": const DropdownListContent(
                                  display: "D", value: "d"),
                              "e": const DropdownListContent(
                                  display: "E", value: "e"),
                              "f": const DropdownListContent(
                                  display: "F", value: "f"),
                              "g": const DropdownListContent(
                                  display: "G", value: "g"),
                              "h": const DropdownListContent(
                                  display: "H", value: "h"),
                              "i": const DropdownListContent(
                                  display: "I", value: "i"),
                              "j": const DropdownListContent(
                                  display: "J", value: "j"),
                            },
                            selected: "a",
                            key: "debug",
                            dropdownListBuilder: (
                              double x,
                              double y,
                              double width,
                              double height,
                              DropdownCotrol control,
                              VoidCallback open,
                              VoidCallback close,
                              VoidCallback update,
                            ) =>
                                GenericSettingsDropdownList(
                              x: x,
                              y: y,
                              height: height,
                              width: width,
                              icon: CarbonIcons.debug,
                              control: control,
                              open: open,
                              close: close,
                              update: update,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
