import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:ghconnect/core/theme/app_theme.dart';
import 'package:ghconnect/core/provider/theme_provider.dart';
import 'package:ghconnect/core/provider/user_provider.dart';

import 'app/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://yvfculcvculyqrierkce.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl2ZmN1bGN2Y3VseXFyaWVya2NlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg4MTg2MTIsImV4cCI6MjA2NDM5NDYxMn0.hwX1e2CsDTyjfRFnwNtw_0Q7kXEsVDAS7faxq1ZqSog',
  );

  // Initialize Awesome Notifications
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

  // Ask notification permission on Android 13+
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  runApp(const GhanaLoveApp());
}

class GhanaLoveApp extends StatelessWidget {
  const GhanaLoveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'GhanaLove',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: '/splash',
            routes: appRoutes,
            onGenerateRoute: onGenerateRoute,
            builder: (context, child) {
              final data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                  textScaler: TextScaler.linear(
                    data.textScaleFactor.clamp(1.0, 1.1),
                  ),
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
              Locale('en', ''), // English
              Locale('ak', ''), // Twi (Akan)
              Locale('ga', ''), // Ga
            ],
          );
        },
      ),
    );
  }
}
