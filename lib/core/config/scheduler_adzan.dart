import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:jadwal_sholat/common/constants/constants.dart';
import 'package:jadwal_sholat/core/utils/datetime_helper.dart';
import 'package:jadwal_sholat/data/datasources/sholat_remote.dart';
import 'package:jadwal_sholat/data/models/sholat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> callbackRegisterAlarm() async {
    final preference = await SharedPreferences.getInstance();

    final date = DateTime.now();
    final currentDate = "${date.year}/${date.month}/${date.day}";

    var dateAlarmSaved = preference.getString(dateAlarm);

    if (dateAlarmSaved != currentDate) {
      try {
        log("Setting alarm...");

        var result =
            await SholatRemoteImpl().getSholatSchedule(idCity, currentDate);

        await setAlarm(result.jadwal);
        await preference.setString(dateAlarm, currentDate);

        log("Success set alarm");
      } catch (e) {
        log("Failed set alarm $e");
      }
    } else {
      log("Alarm has been set");
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  @pragma('vm:entry-point')
  static Future<void> callbackSubuh() async {
    await NotificationHelper().showNotification(subuh);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  @pragma('vm:entry-point')
  static Future<void> callbackDzuhur() async {
    await NotificationHelper().showNotification(dzuhur);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  @pragma('vm:entry-point')
  static Future<void> callbackAshar() async {
    await NotificationHelper().showNotification(ashar);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  @pragma('vm:entry-point')
  static Future<void> callbackMaghrib() async {
    await NotificationHelper().showNotification(maghrib);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  @pragma('vm:entry-point')
  static Future<void> callbackIsya() async {
    await NotificationHelper().showNotification(isya);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  static Future<void> setAlarm(JadwalModel jadwal) async {
    DateTime today = DateTime.now();

    DateTime subuh = DateTimeHelper.timeAlarm(jadwal.subuh);
    DateTime dzuhur = DateTimeHelper.timeAlarm(jadwal.dzuhur);
    DateTime ashar = DateTimeHelper.timeAlarm(jadwal.ashar);
    DateTime maghrib = DateTimeHelper.timeAlarm(jadwal.maghrib);
    DateTime isya = DateTimeHelper.timeAlarm(jadwal.isya);

    if (subuh.difference(today).inMinutes >= 0) {
      await AndroidAlarmManager.oneShotAt(
        subuh,
        1,
        BackgroundService.callbackSubuh,
        exact: true,
        wakeup: true,
      );
    }

    if (dzuhur.difference(today).inMinutes >= 0) {
      await AndroidAlarmManager.oneShotAt(
        dzuhur,
        2,
        BackgroundService.callbackDzuhur,
        exact: true,
        wakeup: true,
      );
    }

    if (ashar.difference(today).inMinutes >= 0) {
      await AndroidAlarmManager.oneShotAt(
        ashar,
        3,
        BackgroundService.callbackAshar,
        exact: true,
        wakeup: true,
      );
    }

    if (maghrib.difference(today).inMinutes >= 0) {
      await AndroidAlarmManager.oneShotAt(
        maghrib,
        4,
        BackgroundService.callbackMaghrib,
        exact: true,
        wakeup: true,
      );
    }

    if (isya.difference(today).inMinutes >= 0) {
      await AndroidAlarmManager.oneShotAt(
        isya,
        5,
        BackgroundService.callbackIsya,
        exact: true,
        wakeup: true,
      );
    }
  }
}
