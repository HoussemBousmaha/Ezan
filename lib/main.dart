import 'package:ezan_official/constants.dart';
import 'package:ezan_official/screens/screens_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, _) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: _ ?? const ScreensWrapper(),
        );
      },
      theme: theme,
      home: const ScreensWrapper(),
    );
  }
}
