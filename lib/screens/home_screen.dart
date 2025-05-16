import 'package:exam_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// error
import 'generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // Запрос разрешений (особенно важно для iOS)
    messaging.requestPermission();

    // Обработка уведомлений, когда приложение запущено в foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
      // Здесь можно показывать Snackbar, диалог и т.д.
      if (message.notification != null) {
        final snackBar = SnackBar(content: Text(message.notification!.title ?? ''));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    // Обработка нажатия на уведомление (когда приложение в фоне или закрыто)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('User opened a notification: ${message.notification?.title}');
      // Навигация или другое действие
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      body: Center(
        child: Text(S.of(context).welcome ?? ''),
      ),
    );
  }
}