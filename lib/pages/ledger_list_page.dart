import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:frledger/components/appbar_container.dart';
import 'package:frledger/components/appbar_multipage_panel.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/components/standard_page_layout.dart';
import 'package:frledger/pages/ledger_list_subpages/all_ledger_settings.dart';
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

  PageController controller = PageController(
    initialPage: 1,
  );

  // I18n Functions
  Future<void> getData() async {
    var result = await Internationalization.getTranslationObject(
        context, "ledger_list_page");
    setState(() {
      text = result;
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
        children: [
          AllLedgerSettings(
              header: getText("appsettings"), subheader: subheader),
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
          pageIcons: const [
            CarbonIcons.settings,
            CarbonIcons.catalog,
          ],
        ),
      ),
    );
  }
}
