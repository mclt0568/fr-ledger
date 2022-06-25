import 'package:flutter/widgets.dart';
import 'package:frledger/components/default_text.dart';
import 'package:frledger/globals/styles.dart';

class StandardPageLayout extends StatelessWidget {
  StandardPageLayout({Key? key, this.body, this.appbarOverlay})
      : super(key: key);
  Widget? body;
  Widget? appbarOverlay;

  List<double> getSystemPaddings(BuildContext context) {
    return [
      MediaQuery.of(context).viewPadding.top,
      MediaQuery.of(context).viewPadding.bottom
    ];
  }

  List<double> getSystemSize(BuildContext context) {
    return [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grayBackground,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            0, getSystemPaddings(context)[0], 0, getSystemPaddings(context)[1]),
        child: Stack(
          children: [
            Positioned(
              child: body ?? const SizedBox(),
            ),
            Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(appbarPadding),
                  child: SizedBox(
                    height: appbarHeight,
                    width: getSystemSize(context)[0] - appbarPadding * 2,
                    child: appbarOverlay,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
