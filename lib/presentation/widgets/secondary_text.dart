import 'package:flutter/cupertino.dart';
class SecondaryText extends StatelessWidget {
  final Color? color;
  final String text;
  TextOverflow overFlow;
  double size;

  SecondaryText({
    this.color=const Color(0xFFccc7c5),
    required this.text,
    this.overFlow = TextOverflow.ellipsis,
    this.size=0
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        overflow: overFlow,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size==0?12:size,
          fontWeight: FontWeight.w400,
         )
    );
  }
}