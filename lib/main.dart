import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jadwal_sholat/core/config/notification_helper.dart';
import 'package:jadwal_sholat/presentation/pages/home_page.dart';

import 'common/styles/app_theme.dart';
import 'core/config/scheduler_adzan.dart';
import 'injection.dart' as di;
import 'core/routes/routes.dart';
import 'presentation/bloc/sholat_bloc.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<SholatBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jadwal Sholat',
        theme: AppTheme.light(),
        home: const HomePage(),
        onGenerateRoute: ((settings) {
          return AppRoutes.routes(settings);
        }),
      ),
    );
  }
}
