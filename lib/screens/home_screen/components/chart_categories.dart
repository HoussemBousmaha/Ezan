import 'package:ezan_official/models/categories.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChartsCategories extends HookConsumerWidget {
  const ChartsCategories({Key? key, required this.items, required this.total}) : super(key: key);

  final List<Category> items;
  final double total;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(
        items.length,
        (index) => Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.height(10)),
          child: SizedBox(
            width: SizeConfig.width(170),
            child: Row(
              children: [
                Container(
                  height: SizeConfig.height(30),
                  width: SizeConfig.height(30),
                  decoration: BoxDecoration(
                    color: items[index].color.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    items[index].icon.icon,
                    size: SizeConfig.height(13),
                    color: items[index].icon.color,
                  ),
                ),
                SizeConfig.addHorizontalSpace(10),
                Column(
                  children: [
                    Text(
                      '${items[index].name} ${((items[index].amount / total) * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.height(14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
