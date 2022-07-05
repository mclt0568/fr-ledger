import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/styles.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({Key? key, required this.children, required this.title})
      : super(key: key);
  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: settingsGroupElementPaddingVertical),
          child: DefaultText(
            text: title,
            color: paragraphColorLight,
          ),
        ),
        for (Widget i in children)
          Padding(
            padding: const EdgeInsets.only(
                bottom: settingsGroupElementPaddingVertical),
            child: i,
          ),
      ],
    );
  }
}
