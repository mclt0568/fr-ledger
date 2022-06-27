import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/styles.dart';

class AllLedgerSettings extends StatelessWidget {
  const AllLedgerSettings(
      {Key? key, required this.header, required this.subheader})
      : super(key: key);

  final String header;
  final String subheader;

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
                  children: [
                    // Elements
                  ],
                )),
          )
        ],
      ),
    );
  }
}
