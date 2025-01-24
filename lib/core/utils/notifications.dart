import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class INotificationService {
  Future<void> scheduleNotification({
    required String title,
    required DateTime scheduledDate,
  });
}

class LocalNotificationService implements INotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Future<void> scheduleNotification({
    required String title,
    required DateTime scheduledDate,
  }) async {
    final notificationTime = tz.TZDateTime.from(
      scheduledDate,
      tz.getLocation('Africa/Cairo'),
    ).subtract(const Duration(minutes: 30));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Task Reminder',
      'Your task "$title" is due in 30 minutes.',
      notificationTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
