import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frledger/components/appbar_container.dart';
import 'package:frledger/components/appbar_multipage_panel.dart';
import 'package:frledger/components/standard_page_layout.dart';
import 'package:frledger/pages/ledger_list_subpages/all_ledger_settings.dart';
import 'package:frledger/pages/ledger_list_subpages/debug_subpage.dart';
import 'package:sprintf/sprintf.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:frledger/globals/internationalization.dart';
import 'package:frledger/pages/ledger_list_subpages/ledger_list.dart';

class LedgerListPage extends StatefulWidget {
  const LedgerListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LedgerListPageState();
  }
}

class _LedgerListPageState extends State<LedgerListPage> {
  Map text = {};
  String version = "";
  bool debugMode = int.parse(dotenv.env["DEBUG"] ?? "0") == 1;

  PageController controller = PageController(
    initialPage: int.parse(dotenv.env["DEBUG"] ?? "0") == 1 ? 2 : 1,
  );

  String currentLanguage = "";

  // I18n Functions
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
  // I18n Functions End

  @override
  Widget build(BuildContext context) {
    String subheader = sprintf(getText("frledger"), [version]);

    return StandardPageLayout(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        children: (debugMode ? <Widget>[const DebugSubpage()] : <Widget>[]) +
            [
              const AllLedgerSettings(),
              LedgerList(
                header: getText("allledger"),
                subheader: subheader,
                emptyPrompt: getText("empty"),
              ),
            ],
      ),
      appbarOverlay: AppbarContainer(
        rightPanel: AppbarMultipagePanel(
          pageController: controller,
          mainButtonIcon: CarbonIcons.add_alt,
          onMainButtonTap: () {},
          pageIcons:
              (debugMode ? <IconData>[CarbonIcons.debug] : <IconData>[]) +
                  const [
                    CarbonIcons.settings,
                    CarbonIcons.catalog,
                  ],
        ),
      ),
    );
  }
}
