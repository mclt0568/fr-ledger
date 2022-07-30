import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frledger/components/appbar_container.dart';
import 'package:frledger/components/appbar_multipage_panel.dart';
import 'package:frledger/components/appbar_single_button.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/components/standard_page_layout.dart';
import 'package:frledger/pages/ledger_list_subpages/all_ledger_settings.dart';
import 'package:frledger/pages/ledger_list_subpages/debug_subpage.dart';
import 'package:frledger/pages/ledger_subpages/dashboard_subpage.dart';
import 'package:frledger/pages/ledger_subpages/ledger_settings_subpage.dart';
import 'package:frledger/pages/ledger_subpages/log_subpage.dart';
import 'package:sprintf/sprintf.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:frledger/globals/internationalization.dart';
import 'package:frledger/pages/ledger_list_subpages/ledger_list.dart';

class LedgerPage extends StatefulWidget {
  const LedgerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LedgerPageState();
  }
}

class _LedgerPageState extends State<LedgerPage> {
  Map text = {};

  PageController controller = PageController(
    initialPage: int.parse(dotenv.env["DEBUG"] ?? "0") == 1 ? 2 : 1,
  );

  String currentLanguage = "";

  // I18n Functions
  Future<void> getData() async {
    var result =
        await Internationalization.getTranslationObject(context, "ledger_page");
    var currentLang = await Internationalization.getLanguage();
    setState(() {
      text = result;
      currentLanguage = currentLang;
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
    return StandardPageLayout(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        children: [
          LedgerSettingsSubpage(),
          LogSubpage(),
          DashboardSubpage(),
        ],
      ),
      appbarOverlay: AppbarContainer(
        leftButton: AppbarSingleButton(
          icon: CarbonIcons.catalog,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        rightPanel: AppbarMultipagePanel(
          mainButtonIcon: CarbonIcons.add_alt,
          pageController: controller,
          pageIcons: [
            CarbonIcons.settings,
            CarbonIcons.roadmap,
            CarbonIcons.dashboard,
          ],
        ),
      ),
    );
  }
}
