import 'package:ezan_official/screens/home_screen/components/add_expence_bottom_sheet.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class FloatingActionAddButton extends StatelessWidget {
  const FloatingActionAddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 35,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) {
              return const AddExpenceBottomSheet();
            },
          );
        },
        child: Container(
          height: SizeConfig.height(85),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: SizeConfig.height(50),
          ),
        ),
      ),
    );
  }
}
