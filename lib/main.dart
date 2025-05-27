import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:ghconnect/app/routes.dart';
import 'package:ghconnect/core/theme/app_theme.dart';
import 'package:ghconnect/core/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Awesome Notifications
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      channelDescription: 'Used for match alerts, reminders, etc.',
      defaultColor: Colors.redAccent,
      ledColor: Colors.white,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
  ], debug: true);

  // ✅ Ask notification permission on Android 13+
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const GhanaLoveApp(),
    ),
  );
}

class GhanaLoveApp extends StatelessWidget {
  const GhanaLoveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return MaterialApp.router(
                  title: 'GhanaLove',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeProvider.themeMode,
                  routerConfig: router,
                  builder: (context, child) {
                    // Wrap in MediaQuery to ensure responsive sizing
                    final data = MediaQuery.of(context);
                    return MediaQuery(
                      data: data.copyWith(
                        textScaleFactor: data.textScaleFactor.clamp(1.0, 1.1),
                      ),
                      child: child!,
                    );
                  },
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''),
                    Locale('ak', ''),
                    Locale('ga', ''),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
