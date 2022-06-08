import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class AddBankButton extends StatelessWidget {
  const AddBankButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: SizeConfig.height(100),
        width: SizeConfig.width(80),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
        ),
        child: Icon(
          Icons.add,
          size: SizeConfig.height(30),
          color: Colors.black,
        ),
      ),
    );
  }
}
