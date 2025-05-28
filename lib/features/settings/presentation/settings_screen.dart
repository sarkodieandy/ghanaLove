import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:ghconnect/core/constants/app_strings.dart';
import 'package:ghconnect/core/widgets/custom_button.dart';
import 'package:ghconnect/core/provider/theme_provider.dart';
import 'package:ghconnect/core/provider/user_provider.dart';

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
    final userProvider = Provider.of<UserProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
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
            // Sections
            _buildSectionHeader(
              context,
              AppStrings.account,
              Icons.account_circle_rounded,
            ),
            _buildSettingsCard([
              _SettingsTile(
                icon: Icons.lock_rounded,
                iconColor: colorScheme.primary,
                title: 'Change Password',
                onTap: () => context.push('/settings/password'),
              ),
              _divider(),
              _SettingsTile(
                icon: Icons.money_rounded,
                iconColor: Colors.green,
                title: 'Mobile Money Settings',
                onTap: () => context.push('/settings/momo'),
              ),
            ], isDark),

            const SizedBox(height: 24),
            _buildSectionHeader(
              context,
              AppStrings.privacy,
              Icons.privacy_tip_rounded,
            ),
            _buildSettingsCard([
              _SettingsTile(
                icon: Icons.visibility_rounded,
                iconColor: Colors.blue,
                title: 'Profile Visibility',
                subtitle: 'Public',
                onTap: () => context.push('/settings/visibility'),
              ),
              _divider(),
              _SettingsTile(
                icon: Icons.block_rounded,
                iconColor: Colors.red,
                title: 'Blocked Users',
                onTap: () => context.push('/settings/blocked'),
              ),
            ], isDark),

            const SizedBox(height: 24),
            _buildSectionHeader(
              context,
              AppStrings.notifications,
              Icons.notifications_rounded,
            ),
            _buildSettingsCard([
              _SettingsTile(
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
            ], isDark),

            const SizedBox(height: 24),
            _buildSectionHeader(
              context,
              AppStrings.language,
              Icons.language_rounded,
            ),
            Card(
              elevation: 0,
              color: isDark ? Colors.grey[900] : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
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
            _buildSectionHeader(
              context,
              AppStrings.theme,
              Icons.brightness_6_rounded,
            ),
            _buildSettingsCard([
              _SettingsTile(
                icon: isDark
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                iconColor: isDark ? Colors.indigo : Colors.amber,
                title: 'Dark Mode',
                trailing: Switch(
                  value: isDark,
                  onChanged: (value) => themeProvider.toggleTheme(value),
                  activeColor: colorScheme.primary,
                ),
              ),
            ], isDark),

            const SizedBox(height: 24),
            _SettingsTile(
              icon: Icons.help_center_rounded,
              iconColor: Colors.blueAccent,
              title: AppStrings.helpSupport,
              onTap: () => context.push('/settings/help'),
            ),

            const SizedBox(height: 32),
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

                // 🔁 Navigate to dynamic profile screen
                final userId = userProvider.userId;
                context.go('/profile/$userId');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children, bool isDark) {
    return Card(
      elevation: 0,
      color: isDark ? Colors.grey[900] : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
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

  Widget _divider() => const Divider(height: 1, indent: 56);
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark
                    ? const Color.fromARGB(179, 26, 22, 22)
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded, size: 24),
      onTap: onTap,
    );
  }
}
