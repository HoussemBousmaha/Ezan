import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.style,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: SizeConfig.height(60),
        width: SizeConfig.width(200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
