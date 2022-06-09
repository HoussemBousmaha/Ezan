import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsService extends ChangeNotifier {
  final SmsQuery query = SmsQuery();

  List<SmsMessage> _state = [];
  List<SmsMessage> get state => [..._state];

  Future<void> getMessages([int? smsCount]) async {
    final permission = await Permission.sms.status;

    if (permission.isGranted) {
      final sms = await query.querySms(count: smsCount);
      _state = sms;
    } else {
      await Permission.sms.request();
    }
  }
}
