import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsService {
  final SmsQuery query = SmsQuery();

  Future<List<SmsMessage>> getSmsMessages([int? smsCount]) async {
    final permission = await Permission.sms.status;

    if (permission.isGranted) {
      final sms = await query.querySms(count: smsCount);
      return sms;
    } else {
      await Permission.sms.request();
      return [];
    }
  }
}
