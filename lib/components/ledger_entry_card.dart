import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/styles.dart';

class LedgerEntryCard extends StatefulWidget {
  const LedgerEntryCard(
      {Key? key,
      required this.expPercent,
      required this.planPercent,
      required this.label,
      required this.ledgerID})
      : super(key: key);

  final double expPercent;
  final double planPercent;
  final String label;
  final String ledgerID;

  @override
  State<LedgerEntryCard> createState() => _LedgerEntryCardState();
}

class _LedgerEntryCardState extends State<LedgerEntryCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    double innerItemHeight = ledgerEntryCardHeight -
        (ledgerEntryCardPadding * 2) -
        ledgerEntryCardPrograssHeight;

    double progressWidth = MediaQuery.of(context).size.width -
        (pagePadding * 2) -
        (ledgerEntryCardPadding * 2);

    return GestureDetector(
        onLongPressDown: (d) {
          setState(() {
            hover = true;
          });
        },
        onLongPressUp: () {
          setState(() {
            hover = false;
          });
        },
        onLongPressCancel: () {
          setState(() {
            hover = false;
          });
        },
        onTap: () {},
        child: Container(
            decoration: BoxDecoration(
              color: hover ? accentFocus : white,
              boxShadow: const [slightElevated],
            ),
            height: ledgerEntryCardHeight,
            child: Padding(
                padding: const EdgeInsets.all(ledgerEntryCardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        SizedBox(
                            width: innerItemHeight,
                            height: innerItemHeight,
                            child: const Icon(
                              CarbonIcons.catalog,
                              color: accent,
                              size: standardIconSize,
                            )),
                        DefaultText(text: widget.label)
                      ],
                    )),
                    SizedBox(
                      height: ledgerEntryCardPrograssHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: accent,
                            width:
                                widget.expPercent * progressWidth, // Percentage
                          ),
                          Container(
                            color: secondaryAccentBackground,
                            width: widget.planPercent *
                                progressWidth, // Percentage
                          ),
                          Expanded(child: Container(color: gray))
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
