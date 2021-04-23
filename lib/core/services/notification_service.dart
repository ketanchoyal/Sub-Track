import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sub_track/core/models/subscription/subscription.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

abstract class NotificationService {
  Future scheduleNotification(Subscription subscription);
  Future init();
  Future deleteNotification(Subscription subscription);
}

class NotificationServiceImpl extends NotificationService {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const MethodChannel _platformChannel =
      MethodChannel('ketanchoyal.dev/sub_track');
  @override
  deleteNotification(Subscription subscription) async {}

  @override
  init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('splash');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (value) async {
        print(value);
      },
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName =
        await _platformChannel.invokeMethod<String>('getTimeZoneName');
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

// NOTE SETUP firebase function to convert svg to png hint[https://github.com/firebase/functions-samples/blob/master/convert-images/functions/index.js]
// hint[https://legacy.imagemagick.org/discourse-server/viewtopic.php?t=34207]
// NOTE upload images to firebasestorage
  @override
  scheduleNotification(Subscription subscription) async {
    // final String largeIconPath = await _downloadAndSaveFile(
    //     'https://raw.githubusercontent.com/ketanchoyal/simple-icons/master/icons/1password.svg',
    //     'largeIcon');
    // final String bigPicturePath = await _downloadAndSaveFile(
    //     'https://via.placeholder.com/400x800', 'bigPicture');
    await _configureLocalTimeZone();
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      10,
      "This is Title",
      "This is Body",
      RepeatInterval.everyMinute,
      NotificationDetails(
        iOS: IOSNotificationDetails(
          subtitle: "This is Subtitle",
          threadIdentifier: "threadIdentifier",
        ),
        android: AndroidNotificationDetails(
          "thisIsChannelId",
          "thisIsChannelName",
          "thisIs Descriiption",
          usesChronometer: true,
          subText: "this is sub text",
        ),
      ),
      androidAllowWhileIdle: true,
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> _scheduleMonthlyMondayTenAMNotification() async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'monthly scheduled notification title',
        'monthly scheduled notification body',
        _nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'monthly notification channel id',
            'monthly notification channel name',
            'monthly notificationdescription',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  Future<void> _scheduleYearlyMondayTenAMNotification() async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'yearly scheduled notification title',
        'yearly scheduled notification body',
        _nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'yearly notification channel id',
              'yearly notification channel name',
              'yearly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  tz.TZDateTime _nextInstanceOfMondayTenAM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
    while (scheduledDate.weekday != DateTime.monday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
