import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class MainScreenHeaderContainer extends StatelessWidget {
  const MainScreenHeaderContainer({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.height(40),
      width: SizeConfig.width(130),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: Colors.blueAccent.withOpacity(0.25),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: SizeConfig.height(20),
        ),
      ),
    );
  }
}
