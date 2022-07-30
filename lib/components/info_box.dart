import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/styles.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({Key? key, this.child, this.title}) : super(key: key);

  final Widget? child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Padding(
        padding: const EdgeInsets.all(infoBoxPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              DefaultText(
                text: title!,
                color: headerColor,
                size: defaultParagraphFontSize,
              ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
