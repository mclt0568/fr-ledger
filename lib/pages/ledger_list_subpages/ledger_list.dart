import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/components/ledger_entry_card.dart';
import 'package:frledger/globals/styles.dart';

class LedgerList extends StatelessWidget {
  const LedgerList(
      {Key? key,
      required this.header,
      required this.subheader,
      required this.emptyPrompt})
      : super(key: key);

  final String header;
  final String subheader;
  final String emptyPrompt;

  @override
  Widget build(BuildContext context) {
    Widget emptyPromptWidget = DefaultText();

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
                        text: header, size: headerFontSize, color: headerColor),
                    DefaultText(
                        text: subheader,
                        size: subheaderFontSize,
                        color: paragraphColorDark),
                  ])),
          Expanded(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < 10; i++)
                      const Padding(
                        padding: EdgeInsets.only(
                            bottom: ledgerEntryCardMarginBottom),
                        child: LedgerEntryCard(
                          expPercent: 0.5,
                          planPercent: 0.1,
                          label: "Test",
                          ledgerID: "1",
                        ),
                      ),
                    const SizedBox(
                      height: ledgerEntryCardMarginBottom + appbarHeight,
                      width: 1,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
