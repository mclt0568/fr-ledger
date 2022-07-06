import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/components/generic_settings_dropdown_list.dart';
import 'package:frledger/components/horizontal_dropdown.dart';
import 'package:frledger/components/horizontal_icon_button.dart';
import 'package:frledger/components/settings_group.dart';
import 'package:frledger/controls/dropdown_control.dart';
import 'package:frledger/controls/dropdown_list_content.dart';
import 'package:frledger/globals/internationalization.dart';
import 'package:frledger/globals/styles.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

class AllLedgerSettings extends StatefulWidget {
  const AllLedgerSettings({Key? key}) : super(key: key);

  @override
  State<AllLedgerSettings> createState() => _AllLedgerSettingsState();
}

class _AllLedgerSettingsState extends State<AllLedgerSettings> {
  final Map<String, DropdownListContent> languageListContent = {
    "en": const DropdownListContent(display: "English", value: "en"),
    "zhcn": const DropdownListContent(display: "简体中文", value: "en"),
    "zhtw": const DropdownListContent(display: "正體中文", value: "en"),
    "ve": const DropdownListContent(display: "Vëlhëlkohas", value: "en"),
  };

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

  Future<void> launchGithub() async {
    String url = dotenv.env['GIT_REPO'] ?? "";
    if (url.isEmpty) {
      return;
    }

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
    }
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
                        text: getText("appsettings"),
                        size: headerFontSize,
                        color: headerColor),
                    DefaultText(
                        text: sprintf(getText("frledger"), [version]),
                        size: subheaderFontSize,
                        color: paragraphColorDark),
                  ])),
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SettingsGroup(title: getText("language"), children: [
                        HorizontalDropdown(
                          icon: CarbonIcons.translate,
                          text: Internationalization
                              .languageNames[currentLanguage] as String,
                          control: DropdownCotrol(
                              key: "languages",
                              values: languageListContent,
                              selected: currentLanguage,
                              dropdownListBuilder: (
                                double x,
                                double y,
                                double width,
                                double height,
                                DropdownCotrol control,
                                VoidCallback open,
                                VoidCallback close,
                                VoidCallback update,
                              ) {
                                return GenericSettingsDropdownList(
                                  height: height,
                                  width: width,
                                  x: x,
                                  y: y,
                                  control: control,
                                  open: open,
                                  close: close,
                                  update: update,
                                  icon: CarbonIcons.translate,
                                  onSelect: (String value) {
                                    Internationalization.setLanguage(value);
                                    setState(() {
                                      currentLanguage = value;
                                    });
                                    getData().then((value) {
                                      Fluttertoast.showToast(
                                          msg: getText("restart"));
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () => Restart.restartApp());
                                    });
                                  },
                                );
                              }),
                        )
                      ]),
                      SettingsGroup(
                        title: getText("management"),
                        children: [
                          HorizontalIconButton(
                              icon: CarbonIcons.save,
                              text: getText("exportappdata"))
                        ],
                      ),
                      SettingsGroup(
                        title: getText("about"),
                        children: [
                          HorizontalIconButton(
                              icon: CarbonIcons.information,
                              text: getText("aboutapp")),
                          HorizontalIconButton(
                              icon: CarbonIcons.license,
                              text: getText("viewlicenses")),
                          HorizontalIconButton(
                            icon: CarbonIcons.logo_github,
                            text: getText("githubrepo"),
                            rightIcon: CarbonIcons.launch,
                            onTap: () {
                              launchGithub();
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
