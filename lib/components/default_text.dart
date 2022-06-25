import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frledger/globals/styles.dart';

class DefaultText extends StatelessWidget {
  const DefaultText(
      {Key? key,
      this.text,
      this.color,
      this.size,
      this.weight,
      this.fontFamily})
      : super(key: key);
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: TextStyle(
          fontFamily: fontFamily ?? "Noto Sans",
          fontFamilyFallback: const <String>[
            'Noto Sans',
            'Noto Sans TC',
          ],
          fontSize: size ?? 10,
          color: color ?? paragraphColorDark,
          decoration: TextDecoration.none,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
