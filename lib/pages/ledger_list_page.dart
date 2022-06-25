import 'package:flutter/widgets.dart';

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
    return Container();
  }
}
