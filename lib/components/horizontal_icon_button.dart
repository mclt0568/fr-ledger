import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/styles.dart';

class HorizontalIconButton extends StatefulWidget {
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
  State<HorizontalIconButton> createState() => _HorizontalIconButtonState();
}

class _HorizontalIconButtonState extends State<HorizontalIconButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPressDown: (d) {
        setState(() {
          isHover = true;
        });
      },
      onLongPressUp: () {
        setState(() {
          isHover = false;
        });
      },
      onLongPressCancel: () {
        setState(() {
          isHover = false;
        });
      },
      onLongPressEnd: (d) {
        setState(() {
          isHover = false;
        });
      },
      onLongPressMoveUpdate: (d) {
        setState(() {
          isHover = false;
        });
      },
      child: Container(
        height: settingsButtonHeight,
        decoration: BoxDecoration(
            color: isHover ? backgroundFocus : white,
            boxShadow: const [slightElevated]),
        child: Row(
          children: [
            SizedBox(
              height: settingsButtonHeight,
              width: settingsButtonHeight,
              child: Icon(widget.icon,
                  size: standardIconSize, color: paragraphColorLight),
            ),
            Expanded(
                child:
                    DefaultText(text: widget.text, color: paragraphColorLight)),
            SizedBox(
              height: settingsButtonHeight,
              width: settingsButtonHeight,
              child: Icon(widget.rightIcon,
                  size: standardIconSize, color: paragraphColorLight),
            ),
          ],
        ),
      ),
    );
  }
}
