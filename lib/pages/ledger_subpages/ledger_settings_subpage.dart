import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/internationalization.dart';
import 'package:frledger/globals/styles.dart';

class LedgerSettingsSubpage extends StatefulWidget {
  const LedgerSettingsSubpage({Key? key}) : super(key: key);

  @override
  State<LedgerSettingsSubpage> createState() => _LedgerSettingsSubpageState();
}

class _LedgerSettingsSubpageState extends State<LedgerSettingsSubpage> {
  Map text = {};

  Future<void> getData() async {
    var result =
        await Internationalization.getTranslationObject(context, "ledger_page");
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: headerPadding),
            child: Row(
              children: [
                const DefaultText(
                  text: "",
                  size: headerFontSize,
                  color: accent,
                ),
                DefaultText(
                  text: " ${getText("settings")}",
                  size: headerFontSize,
                  color: headerColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
