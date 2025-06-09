import 'package:flutter/material.dart';

// Screens
import '../core/widgets/messagesScreen.dart';
import '../core/widgets/profile_screen_widget.dart';
import '../features/auth/presentation/auth_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/chat/presentation/chat_screen.dart';
import '../features/matches/presentation/home_screen.dart';
import '../features/matches/presentation/matches_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/premium/presentation/add_transaction.dart';
import '../features/premium/presentation/premium_screen.dart';
import '../features/profile/presentation/profile_creation_screen.dart';
import '../features/profile/presentation/user_settings_screen .dart';
import '../features/safety/presentation/safety_screen.dart';
import '../features/settings/presentation/BlockedUsersScreen.dart';
import '../features/settings/presentation/MobileMoneySettingsScreen.dart';
import '../features/settings/presentation/changePassword.dart';
import '../features/settings/presentation/help_and_support_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/settings/presentation/visibility_settings_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/nearby/presentation/nearby_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/splash': (context) => const SplashScreen(),
  '/onboarding': (context) => const OnboardingScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegistrationScreen(),
  '/home': (context) => const HomeScreen(),
  '/matches': (context) => const MatchesScreen(),
  '/nearby': (context) => NearbyScreen(),
  '/create-profile': (context) => const ProfileCreationScreen(),
  '/premium': (context) => const PremiumScreen(),
  '/transaction': (context) => const TransactionScreen(),
  '/settings': (context) => const SettingsScreen(),
  '/settings/password': (context) => const ChangePasswordScreen(),
  '/settings/momo': (context) => const MobileMoneySettingsScreen(),
  '/settings/visibility': (context) => const VisibilitySettingsScreen(),
  '/settings/blocked': (context) => const BlockedUsersScreen(),
  '/settings/help': (context) => const HelpAndSupportScreen(),
  '/safety': (context) => const SafetyScreen(),
  '/messages': (context) => MessagesScreen(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');

  if (uri.pathSegments.length == 2) {
    final id = uri.pathSegments[1];

    if (uri.pathSegments[0] == 'chat') {
      return MaterialPageRoute(
        builder: (context) => ChatScreen(chatId: id, userName: ''),
        settings: settings,
      );
    }

    if (uri.pathSegments[0] == 'profile') {
      return MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userId: id,
          name: '',
          age: 0,
          location: '',
          bio: '',
          photo: '',
        ),
        settings: settings,
      );
    }

    if (uri.pathSegments[0] == 'settings_user') {
      return MaterialPageRoute(
        builder: (context) => UserSettingsScreen(
          userId: id,
          name: '',
          age: 0,
          location: '',
          bio: '',
          photo: '',
        ),
        settings: settings,
      );
    }
  }

  return MaterialPageRoute(
    builder: (context) =>
        const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
  );
}
