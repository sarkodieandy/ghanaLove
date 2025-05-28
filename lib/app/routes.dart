import 'package:flutter/material.dart';
import 'package:ghconnect/features/nearby/presentation/nearby_screen.dart';
import 'package:go_router/go_router.dart';

// Screens
import '../features/auth/presentation/auth_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/chat/presentation/chat_screen.dart';
import '../features/events/presentation/events_screen.dart';
import '../features/matches/presentation/home_screen.dart';
import '../features/matches/presentation/matches_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/premium/presentation/add_transaction.dart';
import '../features/premium/presentation/premium_screen.dart';
import '../features/profile/presentation/profile_creation_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/safety/presentation/safety_screen.dart';
import '../features/settings/presentation/BlockedUsersScreen.dart';
import '../features/settings/presentation/MobileMoneySettingsScreen.dart';
import '../features/settings/presentation/changePassword.dart';
import '../features/settings/presentation/help_and_support_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/settings/presentation/visibility_settings_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) => _fadePage(state, const SplashScreen()),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) =>
          _slidePage(state, const OnboardingScreen()),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => _fadePage(state, const LoginScreen()),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      pageBuilder: (context, state) =>
          _slideYPage(state, const RegistrationScreen()),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => _fadePage(state, const HomeScreen()),
    ),
    GoRoute(
      path: '/matches',
      name: 'matches',
      pageBuilder: (context, state) => _fadePage(state, const MatchesScreen()),
    ),
    GoRoute(
      path: '/chat/:id',
      name: 'chat',
      pageBuilder: (context, state) {
        final chatId = state.pathParameters['id']!;
        return _slidePage(state, ChatScreen(chatId: chatId));
      },
    ),
    GoRoute(
      path: '/nearby',
      name: 'nearby',
      pageBuilder: (context, state) => _fadePage(state, NearbyScreen()),
    ),
    GoRoute(
      path: '/profile/:id',
      name: 'profile',
      pageBuilder: (context, state) {
        final userId = state.pathParameters['id']!;
        return _fadePage(state, ProfileScreen(userId: userId));
      },
    ),
    GoRoute(
      path: '/create-profile',
      name: 'createProfile',
      pageBuilder: (context, state) =>
          _slidePage(state, const ProfileCreationScreen()),
    ),
    GoRoute(
      path: '/premium',
      name: 'premium',
      pageBuilder: (context, state) =>
          _slideYPage(state, const PremiumScreen()),
    ),
    GoRoute(
      path: '/transaction',
      name: 'transaction',
      pageBuilder: (context, state) =>
          _slidePage(state, const TransactionScreen()),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) => _fadePage(state, const SettingsScreen()),
    ),
    GoRoute(
      path: '/settings/password',
      name: 'changePassword',
      pageBuilder: (context, state) =>
          _slidePage(state, const ChangePasswordScreen()),
    ),
    GoRoute(
      path: '/settings/momo',
      name: 'mobileMoneySettings',
      pageBuilder: (context, state) =>
          _slidePage(state, const MobileMoneySettingsScreen()),
    ),
    GoRoute(
      path: '/settings/visibility',
      name: 'profileVisibility',
      pageBuilder: (context, state) =>
          _slidePage(state, const VisibilitySettingsScreen()),
    ),
    GoRoute(
      path: '/settings/blocked',
      name: 'blockedUsers',
      pageBuilder: (context, state) =>
          _fadePage(state, const BlockedUsersScreen()),
    ),
    GoRoute(
      path: '/settings/help',
      name: 'helpAndSupport',
      pageBuilder: (context, state) =>
          _slidePage(state, const HelpAndSupportScreen()),
    ),
    GoRoute(
      path: '/safety',
      name: 'safety',
      pageBuilder: (context, state) => _fadePage(state, const SafetyScreen()),
    ),
  ],
);

/// Reusable page transitions
CustomTransitionPage _fadePage(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, _, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

CustomTransitionPage _slidePage(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, _, child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
}

CustomTransitionPage _slideYPage(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, _, child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
}
