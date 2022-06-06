import 'package:ezan_official/constants.dart';
// import 'package:ezan_official/providers/expences.dart';
import 'package:ezan_official/screens/home_screen/components/week_days.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddExpenceBottomSheet extends StatelessWidget {
  const AddExpenceBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HookConsumer(
      builder: (context, ref, child) {
        final controller = useTextEditingController();
        final formKey = GlobalKey<FormState>();
        final selectedDayNotifier = useState(0);
        return Column(
          children: [
            SizeConfig.addVerticalSpace(30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(30)),
              child: Form(
                key: formKey,
                child: TextFormField(
                  onChanged: (value) => formKey.currentState?.validate(),
                  controller: controller,
                  validator: (text) {
                    return text == null || text.isEmpty ? 'هذا الحقل مطلوب' : null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'أدخل قيمة مصروفك',
                    labelText: 'مصروف',
                  ),
                ),
              ),
            ),
            SizeConfig.addVerticalSpace(40),
            Text(
              'اختر يوما',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.height(20),
              ),
            ),
            SizeConfig.addVerticalSpace(40),
            WeekDays(
              onDaySelected: (index) {
                selectedDayNotifier.value = index;
              },
              daysNames: daysNames,
              values: List.generate(
                7,
                (index) => selectedDayNotifier.value == index,
              ),
            ),
            SizeConfig.addVerticalSpace(40),
            // GestureDetector(
            //   onTap: () {
            //     if (formKey.currentState!.validate()) {
            //       Navigator.of(context).pop();
            //       ref.read(expencesProvider.notifier).modifyExpence(
            //             selectedDayNotifier.value,
            //             int.parse(controller.text),
            //           );
            //     }
            //   },
            //   child: Container(
            //     height: SizeConfig.height(60),
            //     width: SizeConfig.screenWidth * 0.6,
            //     decoration: BoxDecoration(
            //       color: Colors.blueAccent,
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     alignment: Alignment.center,
            //     child: Text(
            //       'إضافة مصروف',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: SizeConfig.height(20),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
