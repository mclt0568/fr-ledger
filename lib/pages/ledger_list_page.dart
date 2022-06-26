import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:frledger/components/appbar_container.dart';
import 'package:frledger/components/appbar_multipage_panel.dart';
import 'package:frledger/components/appbar_single_button.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/components/standard_page_layout.dart';

import 'package:frledger/globals/internationalization.dart';

class LedgerListPage extends StatefulWidget {
  const LedgerListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LedgerListPageState();
  }
}

class _LedgerListPageState extends State<LedgerListPage> {
  Map text = {};

  PageController controller = PageController(
    initialPage: 2,
  );

  // I18n Functions
  Future<void> getData() async {
    var result = await Internationalization.getTranslationObject(
        context, "ledger_list_page");
    setState(() {
      text = result;
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
        children: const [
          DefaultText(text: "Page 1"),
          DefaultText(text: "Page 2"),
          DefaultText(text: "Page 3"),
        ],
      ),
      appbarOverlay: AppbarContainer(
        leftButton: const AppbarSingleButton(
          icon: CarbonIcons.catalog,
        ),
        rightPanel: AppbarMultipagePanel(
          pageController: controller,
          mainButtonIcon: CarbonIcons.add_alt,
          pageIcons: const [
            CarbonIcons.settings,
            CarbonIcons.roadmap,
            CarbonIcons.dashboard,
          ],
        ),
      ),
    );
  }
}
