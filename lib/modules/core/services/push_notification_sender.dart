import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/notification_model.dart';

class PushNotificationSender {
  static Future<bool> send(NotificationModel notificationModel) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":
              "key=AAAA9Vqolb4:APA91bFfcmKBIyhEkw6R1dZLfJl1cHLWsbfqSH6b_X-sE62WMaTxFgSrsXjbA4z3BerwvBQCfGEujZ7UoOugbluzOryfQAFvmH81U-1qysvrlRcQInFUMpM7lKnB9nlHF53CFcYTqtFp"
        },
        body: jsonEncode({
          'to': notificationModel.token,
          'data': notificationModel.toJsonData(),
          'notification': {
            'title': notificationModel.title,
            'body': notificationModel.message,
          },
        }),
      );
      log("Notification Sent");
      return true;
    } catch (e) {
      log("Notification failed to send $e");
      return false;
    }
  }
}
