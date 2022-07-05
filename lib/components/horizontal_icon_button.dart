import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/styles.dart';

class HorizontalIconButton extends StatelessWidget {
  const HorizontalIconButton(
      {Key? key,
      required this.icon,
      this.rightIcon,
      required this.text,
      this.onTap})
      : super(key: key);

  final IconData icon;
  final IconData? rightIcon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: settingsButtonHeight,
        decoration:
            const BoxDecoration(color: white, boxShadow: [slightElevated]),
        child: Row(
          children: [
            SizedBox(
              height: settingsButtonHeight,
              width: settingsButtonHeight,
              child: Icon(icon,
                  size: standardIconSize, color: paragraphColorLight),
            ),
            Expanded(
                child: DefaultText(text: text, color: paragraphColorLight)),
            SizedBox(
              height: settingsButtonHeight,
              width: settingsButtonHeight,
              child: Icon(rightIcon,
                  size: standardIconSize, color: paragraphColorLight),
            ),
          ],
        ),
      ),
    );
  }
}
