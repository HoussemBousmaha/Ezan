import 'package:ezan_official/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, _) {
        return const Directionality(
          textDirection: TextDirection.rtl,
          child: HomeScreen(),
        );
      },
    );
  }
}
