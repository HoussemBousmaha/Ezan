import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({
    Key? key,
    required this.daysNames,
    required this.values,
    required this.onDaySelected,
  }) : super(key: key);

  final List<String> daysNames;
  final List<bool> values;
  final Function(int) onDaySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.height(60),
      width: SizeConfig.screenWidth,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(20)),
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            onDaySelected(index);
          },
          child: WeekDay(
            day: daysNames[index],
            isSelected: values[index],
          ),
        ),
      ),
    );
  }
}

class WeekDay extends StatelessWidget {
  const WeekDay({
    Key? key,
    required this.day,
    required this.isSelected,
  }) : super(key: key);

  final String day;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height(50),
      width: SizeConfig.height(50),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.width(5)),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.blueAccent.withOpacity(0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.blueAccent.withOpacity(0.5),
          ),
        ],
      ),
      child: Text(
        day,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.blueAccent,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
