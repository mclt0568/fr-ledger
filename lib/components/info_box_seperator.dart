import 'package:flutter/widgets.dart';
import 'package:frledger/globals/styles.dart';

class ColumnSeperator extends StatelessWidget {
  const ColumnSeperator({Key? key, this.height}) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) =>
      SizedBox(height: height ?? infoBoxPadding, width: 1);
}
