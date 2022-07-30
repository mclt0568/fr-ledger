import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/components/horizontal_icon_button.dart';
import 'package:frledger/components/info_box.dart';
import 'package:frledger/components/info_box_data_pair.dart';
import 'package:frledger/components/info_box_seperator.dart';
import 'package:frledger/components/ledger_summary_progress.dart';
import 'package:frledger/components/ledger_progress_bar.dart';
import 'package:frledger/controls/progress_bar_control.dart';
import 'package:frledger/globals/internationalization.dart';
import 'package:frledger/globals/styles.dart';

class DashboardSubpage extends StatefulWidget {
  const DashboardSubpage({Key? key}) : super(key: key);

  @override
  State<DashboardSubpage> createState() => _DashboardSubpageState();
}

class _DashboardSubpageState extends State<DashboardSubpage> {
  Map text = {};

  ProgressBarControl c = ProgressBarControl(0.3);

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
                  text: " ${getText("summary")}",
                  size: headerFontSize,
                  color: headerColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InfoBox(
                    title: getText("monthlybalance"),
                    child: Column(
                      children: [
                        const ColumnSeperator(),
                        Row(
                          children: const [
                            DefaultText(
                              size: largeNumberSize,
                              weight: FontWeight.w300,
                              text: "A\$",
                            ),
                            DefaultText(
                              size: largeNumberSize,
                              weight: FontWeight.w300,
                              text: "123.45",
                              color: accent,
                            ),
                          ],
                        ),
                        const ColumnSeperator(height: infoBoxPaddingSecondary),
                        const LedgerSummaryProgress(
                          expPercent: 0.92,
                          planPercent: 0.05,
                          savingPercent: 0.1,
                        ),
                        const ColumnSeperator(),
                        InfoBoxDataPair(
                          label: getText("totalincome"),
                          values: const [
                            DefaultText(
                              text: "A\$ ",
                              size: defaultParagraphFontSize,
                            ),
                            DefaultText(
                              text: "1.23",
                              size: defaultParagraphFontSize,
                              color: accent,
                            ),
                          ],
                        ),
                        const ColumnSeperator(height: infoBoxPaddingSecondary),
                        InfoBoxDataPair(
                          label: getText("totalspending"),
                          values: const [
                            DefaultText(
                              text: "A\$ ",
                              size: defaultParagraphFontSize,
                            ),
                            DefaultText(
                              text: "1.23",
                              size: defaultParagraphFontSize,
                              color: accent,
                            ),
                          ],
                        ),
                        const ColumnSeperator(height: infoBoxPaddingSecondary),
                        InfoBoxDataPair(
                          label: getText("plannedspending"),
                          values: const [
                            DefaultText(
                              text: "A\$ ",
                              size: defaultParagraphFontSize,
                            ),
                            DefaultText(
                              text: "1.23",
                              size: defaultParagraphFontSize,
                              color: accent,
                            ),
                          ],
                        ),
                        const ColumnSeperator(height: infoBoxPaddingSecondary),
                        InfoBoxDataPair(
                          label: getText("plannedmonthlybalance"),
                          values: const [
                            DefaultText(
                              text: "A\$ ",
                              size: defaultParagraphFontSize,
                            ),
                            DefaultText(
                              text: "1.23",
                              size: defaultParagraphFontSize,
                              color: accent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const ColumnSeperator(
                    height: defaultPageSeperator,
                  ),
                  DefaultText(text: getText("breakdown"), color: headerColor),
                  const ColumnSeperator(
                    height: defaultPageSeperator,
                  ),
                  LedgerProgressBar(
                    control: c,
                    delayed: const Duration(milliseconds: 50),
                    name: "Test",
                    amount: "1.23",
                    color: secondaryAccentBackground,
                    textColor: yellowForeground,
                  ),
                  const ColumnSeperator(
                    height: defaultPageSeperator,
                  ),
                  LedgerProgressBar(
                    control: ProgressBarControl(0.2),
                    delayed: const Duration(milliseconds: 50),
                    name: "Test",
                    amount: "1.23",
                  ),
                  const ColumnSeperator(
                    height: 2 * appbarPadding + appbarHeight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
