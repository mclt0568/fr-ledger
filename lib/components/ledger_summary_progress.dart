import 'package:flutter/widgets.dart';
import 'package:frledger/globals/styles.dart';

class LedgerSummaryProgress extends StatefulWidget {
  const LedgerSummaryProgress({
    Key? key,
    required this.expPercent,
    required this.planPercent,
    required this.savingPercent,
  }) : super(key: key);

  final double expPercent;
  final double planPercent;
  final double savingPercent;

  @override
  State<LedgerSummaryProgress> createState() => _LedgerSummaryProgressState();
}

class _LedgerSummaryProgressState extends State<LedgerSummaryProgress> {
  double _expPercent = 0;
  double _planPercent = 0;

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 10),
      () => setState(
        () {
          _expPercent = widget.expPercent;
          _planPercent = widget.planPercent;
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width -
        (2 * pagePadding) -
        (2 * infoBoxPadding);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: summaryProgressBarHeight,
          width: boxWidth,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                color: gray,
                height: summaryProgressBarHeight,
                width: boxWidth,
              ),
              AnimatedContainer(
                duration: defaultProgressBarAnimation,
                color: secondaryAccentBackground,
                width: (_expPercent * boxWidth) + (_planPercent * boxWidth),
                height: summaryProgressBarHeight,
              ),
              AnimatedContainer(
                duration: defaultProgressBarAnimation,
                color: accent,
                width: _expPercent * boxWidth,
                height: summaryProgressBarHeight,
              ),
              Positioned(
                right: 0,
                top: summaryProgressBarHeight * 0.80,
                child: Container(
                  color: plannedSavingOverlay,
                  height: summaryProgressBarHeight * 0.20,
                  width: widget.savingPercent * boxWidth,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
