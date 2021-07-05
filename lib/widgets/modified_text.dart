import 'package:flutter/material.dart';

class ModifiedText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;

  const ModifiedText({
    Key key,
    this.text,
    this.color,
    this.size,
    this.fontWeight,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
