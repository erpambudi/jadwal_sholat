import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jadwal_sholat/common/constants/constants.dart';
import 'package:jadwal_sholat/main.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(String typeSholat) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "01",
      "High Importance Notifications",
      channelDescription: "This channel is used for important notifications.",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: RawResourceAndroidNotificationSound('adzan'),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    int id = 0;
    String title = "";
    String content = "";

    switch (typeSholat) {
      case subuh:
        id = 1;
        title = "Sholat $typeSholat";
        content = "Hei Jangan tidur terus.. Waktunya sholat subuh..";
        break;
      case dzuhur:
        id = 2;
        title = "Sholat $typeSholat";
        content =
            "Yuk Sholat.. Tinggalkan urusan duniamu dan jalankan kewajibanmu";
        break;
      case ashar:
        id = 3;
        title = "Sholat $typeSholat";
        content =
            "Alhamdulillah sudah sampai waktu sholat ashar.. Yuk sholat..";
        break;
      case maghrib:
        id = 4;
        title = "Sholat $typeSholat";
        content = "Dug dug dug.. Sudah waktunya sholat maghrib.. Yuk sholat..";
        break;
      default:
        id = 5;
        title = "Sholat $typeSholat";
        content =
            "Sampai juga di waktu sholat isya.. Yuk jalanin kewajibannya sekali lagi.";
        break;
    }

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      content,
      platformChannelSpecifics,
    );
  }
}
