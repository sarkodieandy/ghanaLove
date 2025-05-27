import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ghconnect/core/constants/app_strings.dart';
import 'package:ghconnect/core/widgets/custom_button.dart';
import 'package:ghconnect/core/provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

  void _triggerLocalNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1001,
        channelKey: 'basic_channel',
        title: '✅ Notifications Enabled',
        body: 'You will now receive match alerts!',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, size: 28),
          onPressed: () => context.go('/profile'),
        ),
        title: Text(
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            _SectionHeader(
              title: AppStrings.account,
              icon: Icons.account_circle_rounded,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _SettingsTile(
                    icon: Icons.lock_rounded,
                    iconColor: colorScheme.primary,
                    title: 'Change Password',
                    onTap: () => context.push('/settings/password'),
                  ),
                  const Divider(height: 1, indent: 56),
                  _SettingsTile(
                    icon: Icons.money_rounded,
                    iconColor: Colors.green,
                    title: 'Mobile Money Settings',
                    onTap: () => context.push('/settings/momo'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Privacy Section
            _SectionHeader(
              title: AppStrings.privacy,
              icon: Icons.privacy_tip_rounded,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _SettingsTile(
                    icon: Icons.visibility_rounded,
                    iconColor: Colors.blue,
                    title: 'Profile Visibility',
                    subtitle: 'Public',
                    onTap: () => context.push('/settings/visibility'),
                  ),
                  const Divider(height: 1, indent: 56),
                  _SettingsTile(
                    icon: Icons.block_rounded,
                    iconColor: Colors.red,
                    title: 'Blocked Users',
                    onTap: () => context.push('/settings/blocked'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Notifications Section
            _SectionHeader(
              title: AppStrings.notifications,
              icon: Icons.notifications_rounded,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: _SettingsTile(
                icon: Icons.notifications_active_rounded,
                iconColor: Colors.deepOrange,
                title: 'Enable Notifications',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                    if (value) _triggerLocalNotification();
                  },
                  activeColor: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Language Section
            _SectionHeader(
              title: AppStrings.language,
              icon: Icons.language_rounded,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: _selectedLanguage,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.translate_rounded, size: 24),
                  ),
                  items: ['English', 'Twi', 'Ga'].map((language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(
                        language,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _selectedLanguage = value!),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Theme Section
            _SectionHeader(
              title: AppStrings.theme,
              icon: Icons.brightness_6_rounded,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: _SettingsTile(
                icon: themeProvider.isDarkMode
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                iconColor: themeProvider.isDarkMode
                    ? Colors.indigo
                    : Colors.amber,
                title: 'Dark Mode',
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme(value),
                  activeColor: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Help & Support
            _SettingsTile(
              icon: Icons.help_center_rounded,
              iconColor: Colors.blueAccent,
              title: AppStrings.helpSupport,
              onTap: () => context.push('/support'),
            ),
            const SizedBox(height: 32),

            // Save Button
            CustomButton(
              text: AppStrings.saveChanges,
              icon: Icons.save_rounded,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Settings saved'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
                context.go('/profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded, size: 24),
      onTap: onTap,
    );
  }
}
