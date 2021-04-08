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
    // await _configureLocalTimeZone();
    // await _flutterLocalNotificationsPlugin.zonedSchedule(
    //   10,
    //   "This is Title",
    //   "This is Body",
    //   tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    //   NotificationDetails(
    //     iOS: IOSNotificationDetails(
    //       subtitle: "This is Subtitle",
    //       threadIdentifier: "threadIdentifier",
    //     ),
    //     android: AndroidNotificationDetails(
    //       "thisIsChannelId",
    //       "thisIsChannelName",
    //       "thisIs Descriiption",
    //       styleInformation:
    //           BigPictureStyleInformation(FilePathAndroidBitmap(largeIconPath),
    //               // largeIcon: FilePathAndroidBitmap(largeIconPath),
    //               contentTitle: 'overridden <b>big</b> content title',
    //               htmlFormatContentTitle: true,
    //               summaryText: 'summary <i>text</i>',
    //               htmlFormatSummaryText: true),
    //       usesChronometer: true,
    //       subText: "this is sub text",
    //     ),
    //   ),
    //   androidAllowWhileIdle: true,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    // );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
