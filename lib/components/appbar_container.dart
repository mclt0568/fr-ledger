import 'package:flutter/widgets.dart';

class AppbarContainer extends StatelessWidget {
  const AppbarContainer({Key? key, this.leftButton, this.rightPanel})
      : super(key: key);

  final Widget? leftButton;
  final Widget? rightPanel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftButton ?? const SizedBox(),
        rightPanel ?? const SizedBox()
      ],
    );
  }
}
