import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/styles.dart';

class InfoBoxDataPair extends StatelessWidget {
  const InfoBoxDataPair(
      {Key? key, required this.label, this.value, this.values})
      : assert(!(value != null && values != null)), // one of them has to null
        super(key: key);

  final String label;
  final String? value;
  final List<Widget>? values;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DefaultText(
          text: label,
          size: defaultParagraphFontSize,
        ),
        const Spacer(),
        if (value != null)
          DefaultText(
              text: value, size: defaultParagraphFontSize, color: accent),
        if (values != null)
          for (Widget i in values!) i,
      ],
    );
  }
}
