import 'package:animated_fractionally_sized_box/animated_fractionally_sized_box.dart';
import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/components/info_box_seperator.dart';
import 'package:frledger/controls/progress_bar_control.dart';
import 'package:frledger/globals/styles.dart';

class LedgerProgressBar extends StatefulWidget {
  const LedgerProgressBar({
    Key? key,
    this.height,
    this.color,
    this.textColor,
    this.delayed,
    required this.control,
    required this.name,
    required this.amount,
  }) : super(key: key);

  final ProgressBarControl control;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Duration? delayed;
  final String name;
  final String amount;

  @override
  State<LedgerProgressBar> createState() => _LedgerProgressBarState();
}

class _LedgerProgressBarState extends State<LedgerProgressBar> {
  double value = 0;

  @override
  void initState() {
    widget.control.registerListener((v) {
      setState(() {
        value = v;
      });
    });

    Future.delayed(widget.delayed ?? const Duration(milliseconds: 1), () {
      setState(() {
        value = widget.control.value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.control.cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: gray,
          height: widget.height ?? defaultProgressBarHeight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedFractionallySizedBox(
              duration: defaultProgressBarAnimation,
              widthFactor: value,
              child: Container(
                height: widget.height ?? defaultProgressBarHeight,
                color: widget.color ?? accent,
              ),
            ),
          ),
        ),
        const ColumnSeperator(),
        Row(
          children: [
            DefaultText(
              text: "${widget.name} A\$ ",
            ),
            DefaultText(
              text: widget.amount,
              color: widget.textColor ?? widget.color ?? accent,
            ),
          ],
        )
      ],
    );
  }
}
