import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';

final notification = Provider<FlutterLocalNotificationsPlugin>((ref) {
  final androidInitialize = AndroidInitializationSettings('logo');
  final iosInitialize = IOSInitializationSettings();
  final initializationSettings =
      InitializationSettings(android: androidInitialize, iOS: iosInitialize);
  final notification = FlutterLocalNotificationsPlugin();
  notification.initialize(initializationSettings);
  return notification;
});

// class LocalNotification {
//   static void initialize() {
//     final androidInitialize = AndroidInitializationSettings('logo.png');
//     final iosInitialize = IOSInitializationSettings();
//     final initializationSettings =
//         InitializationSettings(android: androidInitialize, iOS: iosInitialize);
//     final notification = FlutterLocalNotificationsPlugin();
//     notification.initialize(initializationSettings);
//   }
// }
